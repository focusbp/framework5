<?php

include_once "ctl/ctl_chat.php";
include_once "ctl/ctl_db.php";
include_once "ctl/ctl_files.php";
include_once "ctl/ctl_fw.php";
include_once "ctl/ctl_media.php";
include_once "ctl/ctl_security.php";
include_once "ctl/ctl_square.php";
include_once "ctl/ctl_ui.php";

interface Controller extends ctl_chat, ctl_db, ctl_files, ctl_fw, ctl_media, ctl_security, ctl_square, ctl_ui {
	
}

