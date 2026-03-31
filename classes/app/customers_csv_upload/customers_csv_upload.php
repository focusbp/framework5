<?php

class customers_csv_upload {

	private $table_name = "customers";
	private $upload_field_name = "csv_file";
	private $upload_save_name = "customers_csv_upload.csv";

	function run(Controller $ctl) {
		$rows = $ctl->db($this->table_name)->getall("id", SORT_ASC);
		$ctl->assign("count", count($rows));
		$ctl->show_multi_dialog("customers_csv_upload", "upload.tpl", "アップロード", 700);
	}

	function upload_exe(Controller $ctl) {
		$file_path = $this->save_uploaded_csv($ctl);
		if ($file_path === "") {
			$ctl->res_error_message($this->upload_field_name, "CSVファイルを選択してください。");
			return;
		}

		$encode = trim((string) $ctl->POST("encode"));
		if ($encode === "") {
			$encode = "UTF-8";
		}
		$allow_encode = ["UTF-8", "sjis-win"];
		if (!in_array($encode, $allow_encode, true)) {
			$ctl->res_error_message("encode", "文字コードは UTF-8 または Shift_JIS を選択してください。");
			return;
		}

		$csv_text = @file_get_contents($file_path);
		if (!is_string($csv_text) || $csv_text === "") {
			$ctl->res_error_message($this->upload_field_name, "CSVファイルを読み込めませんでした。");
			return;
		}

		if ($encode === "sjis-win") {
			$csv_text = mb_convert_encoding($csv_text, "UTF-8", "SJIS-win");
		}

		$fp = fopen("php://temp", "r+");
		if ($fp === false) {
			$ctl->res_error_message($this->upload_field_name, "CSVの処理に失敗しました。");
			return;
		}
		fwrite($fp, $csv_text);
		rewind($fp);

		$header = fgetcsv($fp);
		if (!is_array($header) || count($header) === 0) {
			fclose($fp);
			$ctl->res_error_message($this->upload_field_name, "ヘッダ行を含むCSVファイルを指定してください。");
			return;
		}

		$header_map = $this->build_header_map($header);
		$required_fields = ["contact_name_kana", "email", "phone"];
		foreach ($required_fields as $field_name) {
			if (!isset($header_map[$field_name])) {
				fclose($fp);
				$ctl->res_error_message($this->upload_field_name, "CSVヘッダに {$field_name} がありません。");
				return;
			}
		}

		$insert_count = 0;
		$line_no = 1;
		$db = $ctl->db($this->table_name);
		while (($row = fgetcsv($fp)) !== false) {
			$line_no++;
			$insert_data = $this->build_insert_data($row, $header_map);
			if ($this->is_empty_row($insert_data)) {
				continue;
			}
			if ($insert_data["email"] !== "" && !filter_var($insert_data["email"], FILTER_VALIDATE_EMAIL)) {
				fclose($fp);
				$ctl->res_error_message($this->upload_field_name, $line_no . "行目のメールアドレス形式が不正です。");
				return;
			}

			$db->insert($insert_data);
			$insert_count++;
		}
		fclose($fp);

		if ($insert_count === 0) {
			$ctl->res_error_message($this->upload_field_name, "取込対象のデータ行がありません。");
			return;
		}

		$ctl->close_multi_dialog("customers_csv_upload");
		$ctl->show_notification_text($insert_count . "件を取り込みました。");
		$ctl->invoke("page", ["db_id" => 18], "db_exe");
	}

	private function save_uploaded_csv(Controller $ctl): string {
		if ($ctl->is_posted_file($this->upload_field_name)) {
			$ctl->save_posted_file($this->upload_field_name, $this->upload_save_name);
			return (string) $ctl->get_saved_filepath($this->upload_save_name);
		}

		if (!$this->is_cli_uploaded_file()) {
			return "";
		}

		$ctl->save_posted_file($this->upload_field_name, $this->upload_save_name);
		return (string) $ctl->get_saved_filepath($this->upload_save_name);
	}

	private function is_cli_uploaded_file(): bool {
		if (!defined("CLI_APP_CALL")) {
			return false;
		}
		if (empty($_FILES[$this->upload_field_name]) || !is_array($_FILES[$this->upload_field_name])) {
			return false;
		}
		$file = $_FILES[$this->upload_field_name];
		if (($file["error"] ?? UPLOAD_ERR_NO_FILE) !== UPLOAD_ERR_OK) {
			return false;
		}
		if ((int) ($file["size"] ?? 0) <= 0) {
			return false;
		}
		$tmp_name = (string) ($file["tmp_name"] ?? "");
		return ($tmp_name !== "" && is_file($tmp_name));
	}

	private function build_header_map(array $header): array {
		$aliases = [
			"contact_name_kana" => ["contact_name_kana", "氏名（フリガナ）"],
			"email" => ["email", "メールアドレス"],
			"phone" => ["phone", "電話番号"],
		];

		$normalized_header = [];
		foreach ($header as $idx => $value) {
			$text = trim((string) $value);
			if ($idx === 0) {
				$text = preg_replace('/^\xEF\xBB\xBF/u', '', $text);
			}
			$normalized_header[$idx] = $text;
		}

		$map = [];
		foreach ($aliases as $field_name => $candidates) {
			foreach ($normalized_header as $idx => $label) {
				if (in_array($label, $candidates, true)) {
					$map[$field_name] = $idx;
					break;
				}
			}
		}
		return $map;
	}

	private function build_insert_data(array $row, array $header_map): array {
		$insert_data = [];
		$insert_data["contact_name_kana"] = trim((string) ($row[$header_map["contact_name_kana"]] ?? ""));
		$insert_data["email"] = trim((string) ($row[$header_map["email"]] ?? ""));
		$insert_data["phone"] = trim((string) ($row[$header_map["phone"]] ?? ""));
		return $insert_data;
	}

	private function is_empty_row(array $insert_data): bool {
		foreach ($insert_data as $value) {
			if (trim((string) $value) !== "") {
				return false;
			}
		}
		return true;
	}
}
