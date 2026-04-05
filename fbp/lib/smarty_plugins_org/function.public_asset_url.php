<?php

function smarty_function_public_asset_url($params, Smarty_Internal_Template $template) {
	$key = trim((string) ($params["key"] ?? ""));
	$id = trim((string) ($params["id"] ?? ""));
	$assign = trim((string) ($params["assign"] ?? ""));

	$ctl = $template->getTemplateVars("_ctl");
	if (!is_object($ctl)) {
		$ctl = $template->getTemplateVars("ctl");
	}
	if (!is_object($ctl) || !method_exists($ctl, "get_APP_URL")) {
		return "";
	}

	$query = [];
	if ($key !== "") {
		$query["key"] = $key;
	} elseif ($id !== "") {
		$query["id"] = $id;
	} else {
		return "";
	}

	$url = $ctl->get_APP_URL("public_asset_media", "view", $query);
	if ($assign !== "") {
		$template->assign($assign, $url);
		return "";
	}
	return $url;
}
