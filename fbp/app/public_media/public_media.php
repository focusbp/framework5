<?php

class public_media {

	function __construct(Controller $ctl) {
		$ctl->set_check_login(false);
	}

	private function mediaPayload(Controller $ctl) {
		$token = trim((string) ($ctl->GET("token") ?? $ctl->POST("token") ?? ""));
		if ($token === "") {
			return null;
		}
		try {
			$json = $ctl->decrypt($token);
		} catch (Exception $e) {
			return null;
		}
		$payload = json_decode((string) $json, true);
		if (!is_array($payload)) {
			return null;
		}
		$path = trim((string) ($payload["path"] ?? ""));
		if ($path === "" || !$ctl->is_saved_file($path)) {
			return null;
		}
		$filename = trim((string) ($payload["filename"] ?? ""));
		if ($filename === "") {
			$filename = basename($path);
		}
		return [
		    "path" => $path,
		    "filename" => $filename,
		    "mode" => trim((string) ($payload["mode"] ?? "")),
		];
	}

	private function resNotFound() {
		header("HTTP/1.1 404 Not Found");
		echo "Not Found";
	}

	private function asciiFilename($filename) {
		$ascii = preg_replace('/[^A-Za-z0-9._-]/', '_', (string) $filename);
		if ($ascii === null || $ascii === "" || $ascii === "." || $ascii === "..") {
			$ascii = "download";
		}
		return $ascii;
	}

	function download_file(Controller $ctl) {
		$payload = $this->mediaPayload($ctl);
		if (empty($payload)) {
			$this->resNotFound();
			return;
		}
		$path = (string) ($payload["path"] ?? "");
		$filepath = $ctl->dirs->datadir . "/upload/" . $path;
		if (!is_file($filepath)) {
			$this->resNotFound();
			return;
		}

		$mimeType = function_exists("mime_content_type") ? mime_content_type($filepath) : "";
		if (!is_string($mimeType) || $mimeType === "") {
			$mimeType = "application/octet-stream";
		}
		$filename = (string) ($payload["filename"] ?? basename($path));
		$asciiFilename = $this->asciiFilename($filename);

		header("Content-Type: " . $mimeType);
		header("Content-Length: " . filesize($filepath));
		header("Content-Disposition: attachment; filename=\"" . addcslashes($asciiFilename, '"\\') . "\"; filename*=UTF-8''" . rawurlencode($filename));
		header("Cache-Control: private, max-age=0, must-revalidate");

		readfile($filepath);
		exit();
	}

	function view_image(Controller $ctl) {
		$payload = $this->mediaPayload($ctl);
		if (empty($payload)) {
			$this->resNotFound();
			return;
		}
		$ctl->res_saved_image((string) $payload["path"], true, 3600, true);
	}
}
