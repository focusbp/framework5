<?php

function smarty_function_public_asset_img($params, Smarty_Internal_Template $template) {
	$key = trim((string) ($params["key"] ?? ""));
	$id = trim((string) ($params["id"] ?? ""));
	$alt = (string) ($params["alt"] ?? "");
	$assign = trim((string) ($params["assign"] ?? ""));

	$url = smarty_function_public_asset_url([
		"key" => $key,
		"id" => $id,
	], $template);
	if ($url === "") {
		return "";
	}

	unset($params["key"], $params["id"], $params["alt"], $params["assign"]);

	$attrs = [
		"src" => $url,
		"alt" => $alt,
	];

	foreach ($params as $name => $value) {
		$name = trim((string) $name);
		if ($name === "") {
			continue;
		}
		$attrs[$name] = (string) $value;
	}

	$parts = [];
	foreach ($attrs as $name => $value) {
		$parts[] = $name . '="' . htmlspecialchars($value, ENT_QUOTES, "UTF-8") . '"';
	}

	$html = "<img " . implode(" ", $parts) . ">";
	if ($assign !== "") {
		$template->assign($assign, $html);
		return "";
	}
	return $html;
}
