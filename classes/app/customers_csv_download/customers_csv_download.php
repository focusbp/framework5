<?php

class customers_csv_download {

	private $table_name = "customers";

	function run(Controller $ctl) {
		$rows = $ctl->db($this->table_name)->getall("id", SORT_ASC);
		$ctl->assign("count", count($rows));
		$ctl->show_multi_dialog("customers_csv_download", "download.tpl", "CSV Download", 600);
	}

	function csv_download(Controller $ctl) {
		$rows = $ctl->db($this->table_name)->getall("id", SORT_ASC);
		$encode = trim((string) $ctl->POST("encode"));
		if ($encode === "") {
			$encode = "UTF-8";
		}

		$allow_encode = ["UTF-8", "sjis-win"];
		if (!in_array($encode, $allow_encode, true)) {
			$ctl->res_error_message("encode", "Unsupported encoding.");
			return;
		}

		$ctl->res_csv(["氏名（フリガナ）", "メールアドレス"], $encode);
		foreach ($rows as $row) {
			$ctl->res_csv([
				(string) ($row["contact_name_kana"] ?? ""),
				(string) ($row["email"] ?? ""),
			], $encode);
		}
	}
}
