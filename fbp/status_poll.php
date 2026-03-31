<?php

ini_set('display_errors', 1);
error_reporting(E_ALL & ~E_NOTICE);
mb_internal_encoding("UTF-8");

include(__DIR__ . "/interface/openai/StatusManager.php");
include(__DIR__ . "/interface/openai/Logger.php");
include(__DIR__ . "/lib/openai/SessionStatusManager.php");
include(__DIR__ . "/lib/openai/FileStatusManager.php");
include(__DIR__ . "/lib/openai/SessionLogger.php");
include(__DIR__ . "/lib/Dirs.php");

$windowcode = $_REQUEST["windowcode"] ?? "";
$vectorStoreName = $_REQUEST["vectorstore"] ?? "";
$identifer = $_REQUEST["identifer"] ?? "";   // ユニークな文字を暗号化したもの(WEBからのアクセスの履歴を保存するため)
$stop = $_REQUEST["stop"] ?? null;

try {
	if(empty($identifer)){
		session_start();
		
		if(empty($windowcode) || empty($vectorStoreName)){
			throw new \Exception("Parameters are not enough.");
		}
		
		$status_manager = new \openai\SessionStatusManager($windowcode, $vectorStoreName);
		$network_logger = new \openai\SessionLogger($windowcode,$vectorStoreName);
	}else{
		$status_manager = new \openai\FileStatusManager($identifer);
		$network_logger = null;
		if ($stop !== null) {
			$status_manager->set_stop_requested((string) $stop === "1");
			if ((string) $stop === "1") {
				$status_manager->set_status("STOP requested by user");
			}
		}
	}
	$response['ok'] = true;
	$response['status_message'] = $status_manager->get_status();
	if ($status_manager instanceof \openai\FileStatusManager) {
		$response["stop_requested"] = $status_manager->is_stop_requested();
		$response["continue_available"] = $status_manager->is_continue_available();
		$response["running"] = $status_manager->is_running();
		$progress = $status_manager->get_progress();
		$response["progress_current"] = (int) ($progress["current"] ?? 0);
		$response["progress_max"] = (int) ($progress["max"] ?? 40);
	}
	if($network_logger != null){
		$response['log'] = $network_logger->get_log();
	}
	if ($response['status_message'] == "END") {
		$response['done'] = true;
	} else {
		$response['done'] = false;
	}
	outputJson($response);
} catch (\Throwable $e) {
	$response['ok'] = true;
	$response['status_message'] = "ERROR";
	$response["error"] = $e->getMessage();
	$response['done'] = true;
	outputJson($response);
}

exit;

/**
 * JSONを返して終了する小ヘルパ
 */
function outputJson(array $data) {

	$origin = isset($_SERVER['HTTP_ORIGIN']) ? trim($_SERVER['HTTP_ORIGIN']) : '';
	header('Access-Control-Allow-Origin: ' . $origin);
	header('Access-Control-Allow-Credentials: true');
	header('Content-Type: application/json; charset=utf-8');
	header('Cache-Control: no-store, no-cache, must-revalidate, max-age=0');
	header('Pragma: no-cache');
	echo json_encode($data, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
}
