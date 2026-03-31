<?php

declare(strict_types=1);

/**
 * Linux ユーザ crontab 登録用クラス
 *
 * - add() でメモリ上に cron 行を追加
 * - write_all() で現在のユーザ crontab を全て上書き
 *
 * 前提:
 * - 実行ユーザが crontab コマンドを利用可能であること
 * - OS は Linux を想定（その他では例外）
 */
class CronRegister {

	/**
	 * @var string[] cron 行の配列
	 */
	private $lines = [];

	/**
	 * コンストラクタ
	 *
	 * @throws \RuntimeException Linux 以外で呼び出された場合
	 */
	public function __construct() {
		if (PHP_OS_FAMILY !== 'Linux') {
			throw new \RuntimeException('CronRegister は Linux 環境専用です。');
		}
	}

	/**
	 * cron 行を追加（メモリ上に保持するだけ）
	 *
	 * @param string $min     分（0-59, 5分おきなど）
	 * @param string $hour    時（0-23, 毎時など）
	 * @param string $day     日（1-31, 毎日など）
	 * @param string $month   月（1-12, 毎月など）
	 * @param string $weekday 曜日（0-7, * など / 0 と 7 が日曜）
	 * @param string $command 実行コマンド
	 *
	 * @return void
	 *
	 * @throws \InvalidArgumentException コマンドが空の場合
	 */
	public function add(
		array $min,
		array $hour,
		array $day,
		array $month,
		array $weekday,
		string $command
	): void {
		// 簡易バリデーション：改行を含めないようにする（複数行挿入防止）
		$min = $this->sanitizeField("min",$min);
		$hour = $this->sanitizeField("hour",$hour);
		$day = $this->sanitizeField("day",$day);
		$month = $this->sanitizeField("month",$month);
		$weekday = $this->sanitizeField("weekday",$weekday);
		$command = $this->sanitizeCommand($command);

		if ($command === '') {
			throw new \InvalidArgumentException('コマンドが空のため、cron 行を追加できません。');
		}

		$line = sprintf(
			'%s %s %s %s %s %s',
			$min,
			$hour,
			$day,
			$month,
			$weekday,
			$command
		);

		$this->lines[] = $line;
	}

	/**
	 * 現在保持している cron 行でユーザ crontab を全て上書き
	 *
	 * - 既存の cron はすべて消える（このクラスが持つ行のみになる）
	 *
	 * @return void
	 *
	 * @throws \RuntimeException crontab コマンドの起動・実行に失敗した場合
	 */
	public function write_all(): void {
		// 空でも OK（= そのユーザの crontab を空にする）
		$cronContent = '';
		if (!empty($this->lines)) {
			$cronContent = implode(PHP_EOL, $this->lines) . PHP_EOL;
		}

		// crontab - に標準入力から流し込む
		$descriptorspec = [
		    0 => ['pipe', 'r'], // stdin
		    1 => ['pipe', 'w'], // stdout
		    2 => ['pipe', 'w'], // stderr
		];

		$process = proc_open('crontab -', $descriptorspec, $pipes);

		if (!is_resource($process)) {
			throw new \RuntimeException('crontab コマンドの起動に失敗しました。');
		}

		// 標準入力に書き込む
		fwrite($pipes[0], $cronContent);
		fclose($pipes[0]);

		// 出力を取得（必要ならログ用に外で使える）
		$stdout = stream_get_contents($pipes[1]);
		fclose($pipes[1]);

		$stderr = stream_get_contents($pipes[2]);
		fclose($pipes[2]);

		$exitCode = proc_close($process);

		if ($exitCode !== 0) {
			$message = trim($stderr);
			if ($message === '') {
				$message = 'crontab コマンドの実行に失敗しました。終了コード: ' . $exitCode;
			} else {
				$message .= ' (終了コード: ' . $exitCode . ')';
			}

			// 必要に応じて STDOUT も含める
			$stdout = trim($stdout);
			if ($stdout !== '') {
				$message .= ' / STDOUT: ' . $stdout;
			}

			throw new \RuntimeException($message);
		}
	}

	/**
	 * 登録済みの cron 行を全て破棄（メモリ上のみ）
	 *
	 * @return void
	 */
	public function clear(): void {
		$this->lines = [];
	}

	/**
	 * cron フィールド用の簡易サニタイズ
	 *
	 * - 前後の空白除去
	 * - 改行コード除去
	 *
	 * @param string $value
	 * @return string
	 */
	private function sanitizeField(string $item_name, array $value): string
	{
	    // 項目ごとの全パターン
	    $allOptions = [
		'min'     => range(0, 59),
		'hour'    => range(0, 23),
		'day'     => range(1, 31),
		'month'   => range(1, 12),
		'weekday' => range(0, 6), // Sun(0)〜Sat(6)
	    ];

	    if (!isset($allOptions[$item_name])) {
		throw new InvalidArgumentException('未知の項目です: ' . $item_name);
	    }

	    // 何もチェックされていなければ「毎回」
	    if (empty($value)) {
		    if($item_name == "min"){
			return '*/10';
		    }else{
			return '*';
		    }
	    }

	    // 数値として正規化
	    $vals = array_map('intval', $value);
	    $vals = array_values(array_unique($vals));
	    sort($vals);

	    // 全選択されているなら「毎回」
	    if ($vals === $allOptions[$item_name]) {
		return '*';
	    }

	    // 部分選択はカンマ区切り
	    return implode(',', $vals);
	}


	/**
	 * コマンド用サニタイズ
	 *
	 * - 前後の空白除去
	 * - 改行コード除去（複数行挿入防止）
	 *
	 * コマンド内容そのものの正当性まではチェックしない。
	 *
	 * @param string $command
	 * @return string
	 */
	private function sanitizeCommand(string $command): string {
		$command = trim($command);
		$command = str_replace(["\r", "\n"], ' ', $command);
		return trim($command);
	}
}
