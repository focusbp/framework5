<?php

class customers_show_list {

	function run(Controller $ctl) {
		$ctl->invoke("page", ["tb_name" => "customers"], "db_exe");
	}
}
