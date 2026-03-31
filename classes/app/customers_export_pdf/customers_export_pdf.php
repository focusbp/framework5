<?php

class customers_export_pdf {

	private $table_name = "customers";

	function run(Controller $ctl) {
		$rows = $ctl->db($this->table_name)->getall("id", SORT_ASC);
		$ctl->assign("count", count($rows));
		$ctl->show_multi_dialog("customers_export_pdf", "download.tpl", "PDF", 600);
	}

	function download_pdf(Controller $ctl) {
		$field_list = $ctl->db("db_fields", "db")->select("db_id", 18, true, "AND", "sort", SORT_ASC);
		$rows = $ctl->db($this->table_name)->getall("id", SORT_ASC);

		$pdf = $ctl->create_pdfmaker();
		$pdf->setPageLayout(["orientation" => "L"]);
		$pdf->addText("customers list", ["fontsize" => "16", "underline" => true]);
		$pdf->addText("Total: " . count($rows), ["margintop" => 2]);

		$table = [];
		$header = ["ID"];
		$dropdown_map = [];
		foreach ($field_list as $field) {
			$header[] = $field["parameter_title"];
			if (!empty($field["constant_array_name"])) {
				$dropdown_map[$field["parameter_name"]] = $ctl->get_constant_array($field["constant_array_name"], false);
			}
		}
		$table[] = $header;

		foreach ($rows as $row) {
			$line = [(string) ($row["id"] ?? "")];
			foreach ($field_list as $field) {
				$name = $field["parameter_name"];
				$value = $row[$name] ?? "";
				if (isset($dropdown_map[$name])) {
					$key = (string) $value;
					if (isset($dropdown_map[$name][$key])) {
						$value = $dropdown_map[$name][$key];
					}
				}
				if (is_array($value)) {
					$value = implode(",", $value);
				}
				$line[] = (string) $value;
			}
			$table[] = $line;
		}

		$column_count = max(1, count($header));
		$column_sizes = [];
		$base = floor((100 / $column_count) * 100) / 100;
		for ($i = 0; $i < $column_count - 1; $i++) {
			$column_sizes[] = $base;
		}
		$used = $base * ($column_count - 1);
		$column_sizes[] = round(100 - $used, 2);

		$pdf->addTable($table, [
			"margintop" => 8,
			"columnsize" => $column_sizes,
		]);
		$pdf->create_pdf();
	}
}
