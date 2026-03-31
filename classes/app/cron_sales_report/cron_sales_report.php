<?php

class cron_sales_report {

	function exec(Controller $ctl) {
		$ffm_orders = $ctl->db("orders");
		$items = $ffm_orders->getall("id", SORT_ASC);

		$total_amount = 0.0;
		foreach ($items as $item) {
			$total_amount += (float) ($item["amount"] ?? 0);
		}

		$setting = $ctl->get_setting();
		$currency = (string) ($setting["currency"] ?? "");
		$dirs = new Dirs();
		$log_line = sprintf(
			"[%s] orders=%d total_amount=%.2f currency=%s\n",
			date("Y-m-d H:i:s"),
			count($items),
			$total_amount,
			$currency
		);

		file_put_contents($dirs->logdir . "/cron_sales_report.log", $log_line, FILE_APPEND | LOCK_EX);
	}
}
