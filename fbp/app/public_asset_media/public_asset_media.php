<?php

class public_asset_media {

	private $asset_dir;

	function __construct(Controller $ctl) {
		$ctl->set_check_login(false);
		$this->asset_dir = dirname(__FILE__) . "/../../../classes/data/public_pages/assets";
	}

	function view(Controller $ctl) {
		$key = trim((string) ($ctl->GET("key") ?? ""));
		$id = (int) ($ctl->GET("id") ?? 0);
		$row = null;
		if ($key !== "") {
			$list = $ctl->db("public_assets", "public_assets")->select("asset_key", $key);
			if (is_array($list) && count($list) > 0) {
				$row = $list[0];
			}
		} elseif ($id > 0) {
			$data = $ctl->db("public_assets", "public_assets")->get($id);
			if (is_array($data) && count($data) > 0) {
				$row = $data;
			}
		}
		if (!is_array($row) || count($row) === 0) {
			$this->resNotFound();
			return;
		}
		if ((int) ($row["enabled"] ?? 0) !== 1) {
			$this->resNotFound();
			return;
		}
		$filename = basename((string) ($row["stored_filename"] ?? ""));
		if ($filename === "") {
			$this->resNotFound();
			return;
		}
		$filepath = $this->asset_dir . "/" . $filename;
		if (!is_file($filepath)) {
			$this->resNotFound();
			return;
		}
		$this->outputImageFile($filepath, (string) ($row["mime_type"] ?? ""));
	}

	private function resNotFound(): void {
		header("HTTP/1.1 404 Not Found");
		echo "Not Found";
	}

	private function outputImageFile(string $filepath, string $mime_type): void {
		session_write_close();
		foreach ($GLOBALS["lock_class_arr"] as $c) {
			$c->close();
		}
		error_reporting(~E_ALL);
		if ($mime_type === "") {
			$mime_type = "application/octet-stream";
			if (class_exists("finfo")) {
				$fi = new finfo(FILEINFO_MIME_TYPE);
				$detected = $fi->file($filepath);
				if (is_string($detected) && $detected !== "") {
					$mime_type = $detected;
				}
			}
		}
		header("Content-Type: " . $mime_type);
		header("X-Content-Type-Options: nosniff");
		header("Cache-Control: public, max-age=3600, immutable");
		header("Content-Length: " . (string) filesize($filepath));
		readfile($filepath);
	}

}
