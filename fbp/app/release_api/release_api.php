<?php

require_once dirname(__FILE__) . "/../release/ReleaseManager.php";

class release_api {

	private $release_manager;

	function __construct(Controller $ctl) {
		$this->release_manager = new ReleaseManager();
		$ctl->set_check_login(false);
	}

	function upload(Controller $ctl) {
		$setting = $ctl->get_setting();
		if (empty($setting["api_key"]) || empty($setting["api_secret"])) {
			http_response_code(422);
			$this->respond_json([
				"ok" => false,
				"error_code" => "hmac_not_configured",
				"error" => "HMAC API key/secret is not configured on the target server.",
			]);
		}

		if ($ctl->verify_api_request() !== true) {
			exit;
		}

		if (!$ctl->is_posted_file("release_file")) {
			http_response_code(400);
			$this->respond_json([
				"ok" => false,
				"error_code" => "release_file_required",
				"error" => $ctl->t("validation.required"),
			]);
		}

		$saved_release_file = "release_api_" . bin2hex(random_bytes(8)) . ".zip";
		$ctl->save_posted_file("release_file", $saved_release_file);
		$zipFile = $ctl->get_saved_filepath($saved_release_file);

		try {
			$info = $this->release_manager->validate_release_zip($ctl, $zipFile);
			$this->release_manager->apply_release_zip($ctl, $zipFile);
			$this->respond_json([
				"ok" => true,
				"message" => $ctl->t("release.success"),
				"info" => $info,
			]);
		} catch (Throwable $e) {
			if (is_file($zipFile)) {
				unlink($zipFile);
			}
			http_response_code(422);
			$this->respond_json([
				"ok" => false,
				"error_code" => "release_failed",
				"error" => $e->getMessage(),
			]);
		}
	}

	private function respond_json(array $payload): void {
		header("Content-Type: application/json; charset=UTF-8");
		echo json_encode($payload, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
		exit;
	}
}
