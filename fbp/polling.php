<?php

include("lib/Dirs.php");

header('Content-Type: text/plain');
header("Cache-Control: no-cache");
header("Access-Control-Allow-Origin: *");

// 出力バッファリングを無効化
while (ob_get_level() > 0) {
    ob_end_flush();
}
ob_implicit_flush(true);

$nickname = $_POST["nickname"];
$polling_id = $_POST["polling_id"];
$status_text = $_POST["status_text"];
$info_data = $_POST["info_data"];

$dirs = new Dirs();
$clientDir = $dirs->pollingdir . "/" . $polling_id;

$remove_folder_after_exit=true;

try {

	if(!is_dir($clientDir)){
		mkdir($clientDir);
	}

	// info.jsonの作成とニックネームの書き込み
	$infoFile = $clientDir . '/info.json';
	
	if(!is_file($infoFile)){
		$fp = fopen($infoFile, 'w+');
		if (flock($fp, LOCK_EX)) { // 排他アクセス
			ftruncate($fp, 0);
			fwrite($fp, json_encode(
				[
				 "polling_id"=>$polling_id,
				 "nickname" => $nickname,
				 "status_text" => $status_text,
				 "info_data"=> $info_data
				]
				, JSON_PRETTY_PRINT));
			fflush($fp);
			flock($fp, LOCK_UN);
		}
		fclose($fp);
	}

	// 登録したディレクトリを終了時に削除する処理を登録
	register_shutdown_function(function () use ($clientDir,&$remove_folder_after_exit) {
		if($remove_folder_after_exit){
			array_map('unlink', glob($clientDir . '/*')); // 中のファイルを削除
			rmdir($clientDir); // ディレクトリを削除
		}
	});

	// ロングポーリングの開始
	$timeout = 600; // タイムアウト秒数(60 = 1分） apacheがタイムアウトしてもfunction.js側で再度接続するので長くてOK
	$startTime = time();

	function getData($clientDir) {
		$files = glob($clientDir . '/msg_*');
		if (!empty($files)) {
			$file = $files[0];
			$data = file_get_contents($file);
			unlink($file); // 読み取ったファイルを削除
			return $data;
		}
		return null;
	}

	while (true) {
		
		// ディレクトリが消されていたらクライアントに通知して終了する。
		if(!is_dir($clientDir)){
			echo json_encode(["success" => false, "message" => "Abort"]);
			exit();
		}
		
		// クライアントの通信が切れていたら終了する
		if(connection_aborted()){
			exit();
		}
		
		// データ更新をチェック
		$data = getData($clientDir);
		$data_decoded = json_decode($data,true);

		if ($data) {
			echo json_encode(["success" => true, "data" => $data_decoded]);
			$keepalive_startTime = time(); //更新する
			$remove_folder_after_exit=false;
			exit();
		}

		// タイムアウトチェック
		if (time() - $startTime > $timeout) {
			echo json_encode(["success" => false, "message" => "Timeout"]);
			exit();
		}

		// 適度にスリープしてサーバー負荷を軽減
		usleep(500000); // 0.5秒
		
		echo " ";
		flush();
	}
} catch (Exception $e) {
	echo json_encode(["success" => false, "message" => $e->getMessage()]);
	exit();
}


