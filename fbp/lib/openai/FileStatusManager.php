<?php

namespace openai;

/**
 * Description of SessionStatusManager
 *
 * @author nakama
 */
class FileStatusManager implements \openai\StatusManager {

	/** @var string */
	private $dir;

	/** @var string */
	private $filename;

	/** @var string */
	private $path;
	/** @var string */
	private $stopPath;
	/** @var string */
	private $continuePath;
	/** @var string */
	private $progressPath;
	/** @var string */
	private $runningPath;

	/**
	 * @param string $dir                   保存先ディレクトリ（無ければ作成）
	 * @param string $filename              保存ファイル名（例: "conv_123.json"）
	 * @param int    $messages_history_max  user/assistant の保存上限（末尾からカウント）
	 */
	// CHANGE: コンストラクタに $messages_history_max を追加
	public function __construct($identifier) {
		$dirs = new \Dirs();
		$baseDir = rtrim($dirs->datadir . "/assistants/status", DIRECTORY_SEPARATOR);

		$this->dir = $baseDir;
		$this->filename = $identifier . ".status";
		$this->path = $this->dir . DIRECTORY_SEPARATOR . $this->filename;
		$this->stopPath = $this->dir . DIRECTORY_SEPARATOR . $identifier . ".stop";
		$this->continuePath = $this->dir . DIRECTORY_SEPARATOR . $identifier . ".continue";
		$this->progressPath = $this->dir . DIRECTORY_SEPARATOR . $identifier . ".progress.json";
		$this->runningPath = $this->dir . DIRECTORY_SEPARATOR . $identifier . ".running";

		// ディレクトリが無ければ作る
		if (!is_dir($this->dir)) {
			mkdir($this->dir, 0777, true);
		}

		// 1/100 の確率で古いステータスファイルをクリーンアップ
		try {
			if (random_int(1, 100) === 1) {
				$this->cleanOldFiles($this->dir);
			}
		} catch (\Exception $e) {
			// random_int / clean 失敗は無視
		}
	}

	/**
	 * 古いステータスファイルを削除する
	 * - 最終更新時刻が 2日以上前の *.status が対象
	 *
	 * @param string $baseDir
	 * @return void
	 */
	private function cleanOldFiles($baseDir) {
		$threshold = time() - 2 * 24 * 60 * 60; // 2 days
		$pattern = $baseDir . DIRECTORY_SEPARATOR . '*.status';

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

	public function set_status(string $status): void {
		try {
			file_put_contents($this->path, $status);
		} catch (\Throwable $ex) {
			//
		}
	}

	public function get_status(): ?string {
		try {
			if (is_file($this->path)) {
				$data = file_get_contents($this->path);
				return $data;
			} else {
				return "";
			}
		} catch (\Throwable $ex) {
			return "";
		}
	}

	public function set_stop_requested(bool $stop): void {
		try {
			file_put_contents($this->stopPath, $stop ? "1" : "0");
		} catch (\Throwable $ex) {
			//
		}
	}

	public function is_stop_requested(): bool {
		try {
			if (!is_file($this->stopPath)) {
				return false;
			}
			$data = trim((string) file_get_contents($this->stopPath));
			return $data === "1";
		} catch (\Throwable $ex) {
			return false;
		}
	}

	public function set_continue_available(bool $continue): void {
		try {
			file_put_contents($this->continuePath, $continue ? "1" : "0");
		} catch (\Throwable $ex) {
			//
		}
	}

	public function is_continue_available(): bool {
		try {
			if (!is_file($this->continuePath)) {
				return false;
			}
			$data = trim((string) file_get_contents($this->continuePath));
			return $data === "1";
		} catch (\Throwable $ex) {
			return false;
		}
	}

	public function set_progress(int $current, int $max): void {
		try {
			$data = [
			    "current" => max(0, $current),
			    "max" => max(1, $max),
			];
			file_put_contents($this->progressPath, json_encode($data, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES));
		} catch (\Throwable $ex) {
			//
		}
	}

	public function get_progress(): array {
		try {
			if (!is_file($this->progressPath)) {
				return ["current" => 0, "max" => 40];
			}
			$data = json_decode((string) file_get_contents($this->progressPath), true);
			if (!is_array($data)) {
				return ["current" => 0, "max" => 40];
			}
			return [
			    "current" => max(0, (int) ($data["current"] ?? 0)),
			    "max" => max(1, (int) ($data["max"] ?? 40)),
			];
		} catch (\Throwable $ex) {
			return ["current" => 0, "max" => 40];
		}
	}

	public function set_running(bool $running): void {
		try {
			file_put_contents($this->runningPath, $running ? "1" : "0");
		} catch (\Throwable $ex) {
			//
		}
	}

	public function is_running(): bool {
		try {
			if (!is_file($this->runningPath)) {
				return false;
			}
			$data = trim((string) file_get_contents($this->runningPath));
			return $data === "1";
		} catch (\Throwable $ex) {
			return false;
		}
	}
}
