<?php

class public_pages {

	function __construct(Controller $ctl) {
		$ctl->set_check_login(false);
	}

	function public_page(Controller $ctl) {
		$asset_key = "asset_65bbfbb3bcb7";
		$asset_url = $ctl->get_APP_URL("public_asset_media", "view", ["key" => $asset_key]);
		$ctl->assign("public_job_asset_url", $asset_url);
		$ctl->assign("public_page_contact_url", $ctl->get_APP_URL("public_pages", "contact"));
		$ctl->show_public_pages("public_page.tpl");
	}

	function contact(Controller $ctl) {
		$asset_key = "asset_65bbfbb3bcb7";
		$ctl->assign("public_asset_url", $ctl->get_APP_URL("public_asset_media", "view", ["key" => $asset_key]));
		$ctl->show_public_pages("contact.tpl");
	}
}
