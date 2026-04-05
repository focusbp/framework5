<?php

if (!function_exists('fields_render_partial_template')) {
	function fields_render_partial_template($template, $file, array $vars = []) {
		$smarty = method_exists($template, 'getSmarty') ? $template->getSmarty() : $template->smarty;
		$subTemplate = $smarty->createTemplate(
			$file,
			$template->cache_id ?? null,
			$template->compile_id ?? null,
			$template
		);
		foreach ($vars as $key => $value) {
			$subTemplate->assign($key, $value);
		}
		return $subTemplate->fetch();
	}
}
