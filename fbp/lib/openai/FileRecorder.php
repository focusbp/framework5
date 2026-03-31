<?php

namespace openai;

/**
 * FileRecorder
 *
 * 指定ディレクトリ内の指定ファイルに会話履歴を保存する(JSON)。
 * - コンストラクタで渡された $dir/$filename を1つの「会話ログ」として扱う
 * - read(): そのJSONを配列で返す（無ければ []）
 * - write(): 丸ごと上書き（保存直前に user/assistant のみ末尾から上限トリム）
 * - append(): 末尾に1件追加（内部で write() を使用）
 *
 * 注意:
 * - 上限判定は user/assistant のみカウント
 * - system/tool などはカウント対象外のため基本的に残る
 */
class FileRecorder implements Recorder {

	/** @var string */
	private $dir;

	/** @var string */
	private $filename;

	/** @var string */
	private $path;

	/** @var int 上限（user/assistant のみを末尾からカウント） */
	private $messages_history_max;

	/**
	 * @param string $dir                   保存先ディレクトリ（無ければ作成）
	 * @param string $filename              保存ファイル名（例: "conv_123.json"）
	 * @param int    $messages_history_max  user/assistant の保存上限（末尾からカウント）
	 */
	// CHANGE: コンストラクタに $messages_history_max を追加
	public function __construct($identifier, int $messages_history_max) {
		
		$dirs = new \Dirs();
		$dir = $dirs->datadir . "/assistants/history/";
		
		$this->dir = rtrim($dir, DIRECTORY_SEPARATOR);
		$this->filename = $identifier . ".json";
		$this->path = $this->dir . DIRECTORY_SEPARATOR . $this->filename;
		$this->messages_history_max = ($messages_history_max > 0) ? $messages_history_max : 1;

		// ディレクトリが無ければ作る
		if (!is_dir($this->dir)) {
			mkdir($this->dir, 0777, true);
		}

		// ファイルが無ければ初期化（空配列を書いておく）
		if (!file_exists($this->path)) {
			$this->write([]);
		}
	}

	/** @inheritdoc */
	public function read(): array {
		if (!file_exists($this->path)) {
			return [];
		}

		$json = file_get_contents($this->path);
		if ($json === false || $json === '') {
			return [];
		}

		$data = json_decode($json, true);
		if (!is_array($data)) {
			return [];
		}

		return $data;
	}

	/** @inheritdoc */
	public function write(array $messages): void {
		// CHANGE: 保存前に user/assistant 上限でトリム
		$messages = $this->trimByUserAssistantTail($messages, $this->messages_history_max);

		$json = json_encode(
			array_values($messages),
			JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES | JSON_PRETTY_PRINT
		);

		file_put_contents($this->path, $json);
	}

	/** @inheritdoc */
	public function append(string $role, $content): void {
		$msgs = $this->read();
		$msgs[] = [
		    'role' => $role,
		    'content' => $content,
		];
		$this->write($msgs);
	}

	/**
	 * 末尾から user/assistant を数えて上限超過分を除去（system/tool等は残す）
	 * - 走査は末尾→先頭（保持可否を決めてから順序維持で再構成）
	 *
	 * @param array<int,array<string,mixed>> $messages
	 * @param int $maxUA  上限カウント（user/assistant のみ）
	 * @return array<int,array<string,mixed>>
	 */
	private function trimByUserAssistantTail(array $messages, int $maxUA): array {
		if ($maxUA <= 0 || empty($messages)) {
			return [];
		}

		$n = count($messages);
		$keepFlags = array_fill(0, $n, false);
		$uaCount = 0;

		// 末尾から走査
		for ($i = $n - 1; $i >= 0; $i--) {
			$m = $messages[$i];
			$role = isset($m['role']) ? (string) $m['role'] : '';

			if ($role === 'user' || $role === 'assistant') {
				if ($uaCount < $maxUA) {
					$keepFlags[$i] = true;
					$uaCount++;
				} else {
					// 上限超過 → 保存しない
					$keepFlags[$i] = false;
				}
			} else {
				// system/tool 等は常に保持
				$keepFlags[$i] = true;
			}
		}

		// 順序維持で再構成
		$result = [];
		for ($i = 0; $i < $n; $i++) {
			if ($keepFlags[$i]) {
				$result[] = $messages[$i];
			}
		}

		return $result;
	}
}
