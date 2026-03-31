<?php

class release {

	// Copy list of the databases
	private $db_copy_list = [
	    "lang",
	    "email_format",
	    "db",
	    "constant_array",
	    "webhook_rule",
	    "embed_app",
	    "public_assets",
	    "db_additionals",
	    "dashboard",
	    "cron",
	    "api_studio"
	];
	private $appdir;
	private $datadir;
	private $zipfile;
	private $extractdir;
	private $public_assets_dir;

	function __construct(Controller $ctl) {
		$this->appdir = realpath(dirname(__FILE__) . "/../../../classes/app");
		$this->datadir = realpath(dirname(__FILE__) . "/../../../classes/data");
		$this->extractdir = realpath(dirname(__FILE__) . "/../../../classes");
		$this->public_assets_dir = dirname(__FILE__) . "/../../../classes/data/public_pages/assets";

		$this->zipfile = dirname(__FILE__) . "/../../../classes/log/release.zip";
		$log_dir = dirname(__FILE__) . "/../../../classes/log";
		if (!is_dir($log_dir)) {
			mkdir($log_dir);
		}
	}

	function download_zip(Controller $ctl) {

		$setting = $ctl->get_setting();
		$ctl->assign("setting", $setting);
		if (empty($setting["project_release_code"])) {
			$ctl->assign("message", "Please set the Project Release Code on the settings screen first.");
			$ctl->assign("flg", false);
		} else {
			$ctl->assign("message", "Download Project :" . $setting["project_release_code"]);
			$ctl->assign("flg", true);
		}

		$ctl->show_multi_dialog("download", "download.tpl", "Download Release Package");
	}

	function download_zip_exe(Controller $ctl) {

		$zip = new ZipArchive();
		$setting = $ctl->get_setting();

		if ($zip->open($this->zipfile, ZipArchive::CREATE) !== TRUE) {
			throw new Exception("Can't open zipfile:" . $this->zipfile);
		}

		// info
		$post = $ctl->POST();
		$info = [
		    "project_release_code" => $setting["project_release_code"],
		    "datetime" => $ctl->date("Y/m/d H:i", time(), $ctl->POST("_timezone")),
		    "timezone" => $ctl->POST("_timezone"),
		    "memo" => $ctl->POST("memo"),
		    "type" => "release"
		];
		$json = json_encode($info);
		$zip->addFromString("info.json", $json);

		// app
		$files = new RecursiveIteratorIterator(
			new RecursiveDirectoryIterator($this->appdir),
			RecursiveIteratorIterator::LEAVES_ONLY
		);
		foreach ($files as $name => $file) {
			// Skip directories (they would be added automatically)
			if (!$file->isDir()) {
				$filePath = $file->getRealPath();
				$relativePath = substr($filePath, strlen($this->extractdir) + 1);
				$zip->addFile($filePath, $relativePath);
			}
		}

		// data
		foreach ($this->db_copy_list as $f) {
			try {
				$files = new RecursiveIteratorIterator(
					new RecursiveDirectoryIterator("$this->datadir/$f"),
					RecursiveIteratorIterator::LEAVES_ONLY
				);
				foreach ($files as $name => $file) {
					$filePath = $file->getRealPath();
					if (endsWith($filePath, ".dat")) {
						$relativePath = substr($filePath, strlen($this->extractdir) + 1);
						$zip->addFile($filePath, $relativePath);
					}
				}
			} catch (Exception $e) {
			    // ディレクトリが存在しない場合に例外を無視して次に進む
			    continue;
			}
		}

		// public_pages runtime assets
		$this->addDirectoryFilesToZip($zip, $this->public_assets_dir);

		$zip->close();

		// Output zip file data
		readfile($this->zipfile);

		// Remove the zip file from the server after download
		unlink($this->zipfile);
	}

	function release(Controller $ctl) {
		$setting = $ctl->get_setting();
		$ctl->assign("setting", $setting);
		if (empty($setting["project_release_code"])) {
			$ctl->assign("message", "Please set the Project Release Code on the settings screen first.");
			$ctl->assign("flg", false);
		} else {
			$ctl->assign("message", "Release Project :" . $setting["project_release_code"]);
			$ctl->assign("flg", true);
		}
		$ctl->show_multi_dialog("upgrade", "release.tpl", "Release", 600, true, true);
	}

	function release_confirm(Controller $ctl) {

		$setting = $ctl->get_setting();
		$saved_release_file = "release.zip";

		if ($ctl->is_saved_file($saved_release_file)) {
			$ctl->remove_saved_file($saved_release_file);
		}

		// Upload file to server 
		$ctl->save_posted_file('release_file', $saved_release_file);
		$zipFile = $ctl->get_saved_filepath($saved_release_file);

		// Create a new zip archive
		$zip = new ZipArchive();

		// Open the zip file
		if ($zip->open($zipFile) === TRUE) {
			// check
			if ($zip->locateName('info.json') !== false) {
				$json = $zip->getFromName('info.json');
				$info = json_decode($json, true);
				if ($setting["project_release_code"] == $info["project_release_code"] && $info["type"] == "release") {
					$ctl->assign("info", $info);
					$ctl->assign("flg", true);
				} else {
					$ctl->assign("message", "This is not a release file for this project.");
					$ctl->assign("info", $info);
					$ctl->assign("flg", false);
					unlink($zipFile);
				}
				// Delete info.json
				$zip->deleteName('info.json');
				$zip->close();
			} else {
				$ctl->assign("message", "Cannot open the file uploaded.");
				$ctl->assign("flg", false);
				unlink($zipFile);
			}
		} else {
			$ctl->assign("message", "Cannot open the file uploaded.");
			$ctl->assign("flg", false);
		}
		$ctl->show_multi_dialog("upgrade2", "release_confirm.tpl", "Upgrade", 600, true, true);
	}

	function release_exe(Controller $ctl) {

		$saved_release_file = "release.zip";

		// Delete files
		//app
		$this->deleteDirectoryContents($this->appdir);

		// data
		foreach ($this->db_copy_list as $f) {
			$path = "$this->datadir/$f";
			$this->deleteDirectory($path);
		}
		$this->deleteDirectory($this->public_assets_dir);
		mkdir($this->public_assets_dir, 0777, true);
		// templates_c
		$this->deleteDirectory($this->datadir . "/templates_c");

		// Create a new zip archive
		$zip = new ZipArchive();
		$zipFile = $ctl->get_saved_filepath($saved_release_file);

		// Open the zip file
		if ($zip->open($zipFile) === TRUE) {
			// Extract the files
			$zip->extractTo($this->extractdir);
			// Close the zip archive
			$zip->close();

			unlink($zipFile);

			$ctl->assign("success", "Successfully Released.");
		} else {
			$ctl->assign("fail", "Cannot open <$saved_release_file>\n");
		}
		
		// fmtファイルの再作成
		$ctl->ajax("db","make_table_format");
		
		// cron再設定
		$ctl->cron_set();
		
		$ctl->show_multi_dialog("upgrade2", "release_done.tpl", "Upgrade", 600, true, true);
	}

	function reload(Controller $ctl) {
		$ctl->res_reload();
	}

	// ディレクトリ削除用の関数
	function deleteDirectory($dir) {
		if (!is_dir($dir)) {
			return;
		}
		$items = array_diff(scandir($dir), ['.', '..']);
		foreach ($items as $item) {
			$path = "$dir/$item";
			if (is_dir($path)) {
				$this->deleteDirectory($path);
			} else {
				unlink($path);
			}
		}
		rmdir($dir);
	}

	// 指定したディレクトリの配下を削除する関数
	function deleteDirectoryContents($dir) {
		if (!is_dir($dir)) {
			return;
		}
		$items = array_diff(scandir($dir), ['.', '..']);
		foreach ($items as $item) {
			$path = "$dir/$item";
			if (is_dir($path)) {
				$this->deleteDirectoryContents($path);
				rmdir($path); // 空のディレクトリを削除
			} else {
				unlink($path); // ファイルを削除
			}
		}
	}

	private function addDirectoryFilesToZip(ZipArchive $zip, string $dir): void {
		if (!is_dir($dir)) {
			return;
		}
		$files = new RecursiveIteratorIterator(
			new RecursiveDirectoryIterator($dir),
			RecursiveIteratorIterator::LEAVES_ONLY
		);
		foreach ($files as $file) {
			if ($file->isDir()) {
				continue;
			}
			$filePath = $file->getRealPath();
			if ($filePath === false) {
				continue;
			}
			$relativePath = substr($filePath, strlen($this->extractdir) + 1);
			$zip->addFile($filePath, $relativePath);
		}
	}
}
