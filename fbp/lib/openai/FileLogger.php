<?php

namespace openai;

/**
 * Description of FileLogger
 *
 * @author nakama
 */
class FileLogger implements Logger {

	/** @var string */
	private $dir;

	/** @var string */
	private $filename;

	/** @var string */
	private $path;

	public function __construct($identifier, int $messages_history_max) {
		$dirs = new \Dirs();
		$baseDir = rtrim($dirs->datadir . "/assistants/history", DIRECTORY_SEPARATOR);

		$this->dir = $baseDir;
		$this->filename = $identifier . ".json";
		$this->path = $this->dir . DIRECTORY_SEPARATOR . $this->filename;
		$this->messages_history_max = ($messages_history_max > 0) ? $messages_history_max : 1;

		// ディレクトリが無ければ作る
		if (!is_dir($this->dir)) {
			mkdir($this->dir, 0777, true);
		}

		// 1/100 の確率で古い履歴ファイルをクリーンアップ
		try {
			if (random_int(1, 100) === 1) {
				$this->cleanOldFiles($this->dir);
			}
		} catch (\Exception $e) {
			// random_int / clean 失敗は無視
		}

		// ファイルが無ければ初期化（空配列を書いておく）
		if (!file_exists($this->path)) {
			$this->write([]);
		}
	}

	/**
	 * 古い履歴ファイルを削除する
	 * - 最終更新時刻が 2日以上前の *.json が対象
	 *
	 * @param string $baseDir
	 * @return void
	 */
	private function cleanOldFiles($baseDir): void {
		$threshold = time() - 2 * 24 * 60 * 60; // 2 days
		$pattern = $baseDir . DIRECTORY_SEPARATOR . '*.json';

		foreach (glob($pattern) as $file) {
			if (!is_file($file)) {
				continue;
			}

			$mtime = @filemtime($file);
			if ($mtime === false) {
				continue;
			}

			if ($mtime < $threshold) {
				@unlink($file);
			}
		}
	}

	public function add_log($data) {
		$log_truncate = 3000;
		$log_text = file_get_contents($this->path);
		if (is_array($data)) {
			$data = print_r($data, true) . "\n\n";
		}
		$log_text .= $data . "\n";
		if (strlen($log_text) > $log_truncate) {
			// 長すぎるログは切り詰める
			$log_text = mb_strcut($log_text, -1 * $log_truncate, null, 'UTF-8');
		}
		file_put_contents($this->path, $log_text);
	}

	public function get_log() {
		try {
			if (is_file($this->path)) {
				$log_text = file_get_contents($this->path);
				return $log_text;
			} else {
				return "";
			}
		} catch (\Throwable $ex) {
			return "";
		}
	}

	public function clear_log() {
		try {
			unlink($this->path);
		} catch (\Throwable $ex) {
			//
		}
	}
}
