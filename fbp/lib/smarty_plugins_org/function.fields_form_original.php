<?php

require_once __DIR__ . '/shared.fields_render.php';

/**
 * {fields_form_original
 *   name="field_name"            // required
 *   type="text"                  // required: text/textarea/checkbox/radio/select/date/datetime/year_month...
 *   value=$row.field_name        // optional (default: "")
 *   title="表示名"               // optional
 *   options="OPT_NAME"           // optional: option_name（フレームワーク定数配列名など）
 *   options_arr=$opt             // optional: ["1"=>"A","2"=>"B"] のような配列（options より優先）
 *
 *   template="__item_edit.tpl"
 *   base_template_dir=$base_template_dir
 *   item_margin_top="10px"
 *   field_class_prefix="field_"
 *   value_span_class="row_value"
 * }
 */
function smarty_function_fields_form_original(array $params, Smarty_Internal_Template $template) {

	$name = isset($params['name']) ? (string) $params['name'] : '';
	$type = isset($params['type']) ? (string) $params['type'] : '';

	if ($name === '' || $type === '') {
		trigger_error('{fields_form_original} requires "name" and "type".', E_USER_WARNING);
		return '';
	}

	// 見た目パラメータ（fields_form_direct と同系）
	$tplName = $params['template'] ?? '__item_edit.tpl';
	$baseDir = $params['base_template_dir'] ?? $template->getTemplateVars('base_template_dir') ?? '';
	$itemMargin = $params['item_margin_top'] ?? '10px';
	$fieldPref = $params['field_class_prefix'] ?? 'field_';
	$valueClass = $params['value_span_class'] ?? 'row_value';

	$file = $baseDir ? rtrim($baseDir, '/') . '/' . $tplName : $tplName;

	$keep_row = $template->getTemplateVars("row");

	// value -> row に入れる（__item_edit.tpl が row 参照の想定）
	$value = $params['value'] ?? '';
	$row = [];
	$row[$name] = $value;

	// options
	$optionName = $params['options'] ?? '';
	$optionsArr = $params['options_arr'] ?? null;

	// __item_edit.tpl が見るであろう最低限の field 構造を作る
	$field = [
	    'parameter_name' => $name,
	    'parameter_title' => (string) ($params['title'] ?? ''),
	    'type' => $type,
	    'option_name' => is_string($optionName) ? $optionName : '',
	    'options' => is_array($optionsArr) ? $optionsArr : [], // select/checkbox/radio 用
	];

	// サブテンプレート変数（fields_form_direct と同じ流れ）
	$inner = fields_render_partial_template($template, $file, [
		'row' => $row,
		'field' => $field,
	]);

	// ラップ（fields_form_direct と同系）
	$out = '<div class="'
		. htmlspecialchars($fieldPref, ENT_QUOTES, 'UTF-8')
		. htmlspecialchars($name, ENT_QUOTES, 'UTF-8')
		. '" style="margin-top:' . htmlspecialchars($itemMargin, ENT_QUOTES, 'UTF-8') . ';">'
		. '<span class="' . htmlspecialchars($valueClass, ENT_QUOTES, 'UTF-8') . '">'
		. $inner
		. '</span>'
		. '</div>';

	//戻す
	$template->assign("row", $keep_row);

	return $out;
}
