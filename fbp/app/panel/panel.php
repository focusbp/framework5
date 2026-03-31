<?php

/**
 * Description of panel
 *
 * @author nakama
 */
class panel {


	function __construct(Controller $ctl) {
	}

	function page(Controller $ctl) {
		$ctl->invoke("page", [], "db");
		$ctl->show_main_area("index.tpl", "Development Panel");
	}

	function release_backup(Controller $ctl) {
		$ctl->show_main_area("release_backup.tpl", "Release / Backup");
	}

	
}
