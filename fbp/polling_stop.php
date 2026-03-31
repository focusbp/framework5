<?php

include("lib/Dirs.php");

header('Content-Type: text/plain');
header("Cache-Control: no-cache");
header("Access-Control-Allow-Origin: *");

$rawData = file_get_contents('php://input');

// JSON をデコードして連想配列に変換
$data = json_decode($rawData, true);

if ($data !== null && isset($data['polling_id'])) {
	$polling_id = $data['polling_id'];

	$dirs = new Dirs();
	$clientDir = $dirs->pollingdir . "/" . $polling_id;

	try {

		array_map('unlink', glob($clientDir . '/*')); // 中のファイルを削除
		rmdir($clientDir); // ディレクトリを削除
	} catch (Exception $e) {
		// Nothing to do
	}
}