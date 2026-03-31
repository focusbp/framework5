<?php

namespace openai;

/**
 * SessionRecorder
 *
 * $_SESSION[$windowcode][$vectorStoreName]['_openai_messages']
 * に会話履歴を保存・読み書きする実装。
 */
class SessionRecorder implements Recorder {

	private $windowcode;
	private $vectorStoreName;
	private $sessionKey = '_openai_messages';

	/**
	 * @param string $windowcode
	 * @param string $vectorStoreName
	 */
	public function __construct(string $windowcode, string $vectorStoreName) {
		$this->windowcode = $windowcode;
		$this->vectorStoreName = $vectorStoreName;
	}

	/** @inheritdoc */
	public function read(): array {
		$ret = $_SESSION[$this->windowcode][$this->vectorStoreName][$this->sessionKey];
		if (!empty($ret)) {
			return $ret;
		}
		return [];
	}

	/** @inheritdoc */
	public function write(array $messages): void {
		// インデックスをきれいに揃えて入れる
		$_SESSION[$this->windowcode][$this->vectorStoreName][$this->sessionKey] = array_values($messages);
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

}
