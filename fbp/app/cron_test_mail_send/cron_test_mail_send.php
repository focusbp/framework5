<?php

class cron_test_mail_send {

	public function __construct(Controller $ctl) {
		if ($ctl->GET("function") === "exec") {
			$ctl->set_check_login(false);
		}
	}

	public function exec(Controller $ctl) {
		$ctl->send_mail_text("info@soshiki-kaikaku.com", "test", "test");
	}
}
