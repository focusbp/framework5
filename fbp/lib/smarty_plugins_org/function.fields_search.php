<?php

/**
 * {fields_search
 *    field_group="group_search"           // 既存のフィールド定義配列 or そのテンプレ変数名
 *    db="event"                           // 新: DB/モデル名
 *    fields=["event_name","date_from"]    // 新: 検索に使う項目名配列（Smarty配列/JSON/カンマ区切りOK）
 *    data="search_defaults"               // 任意: 既定値（配列 or 変数名）。未指定なら空配列
 *    ctl=$ctl                             // 任意: コントローラ。省略時はテンプレ変数 "_ctl" を参照
 *    template="__item_search.tpl"         // 呼び出しテンプレート（デフォルト）
 *    base_template_dir=$base_template_dir // ベースパス
 *    field_class_prefix="field_"          // 外側 <div> の接頭辞 => "field_{$parameter_name}"
 *    value_span_class="row_value"         // 値ラッパ <span> のクラス
 *    title_span_class="row_title"         // タイトル <span> のクラス
 * }
 */
function smarty_function_fields_search(array $params, Smarty_Internal_Template $template) {
	$tplName = isset($params['template']) ? $params['template'] : '__item_search.tpl';
	$baseDir = isset($params['base_template_dir']) ? $params['base_template_dir'] : ($template->getTemplateVars('base_template_dir') ?: '');

	$fieldPref = isset($params['field_class_prefix']) ? $params['field_class_prefix'] : 'field_';
	$valueSpanClass = isset($params['value_span_class']) ? $params['value_span_class'] : 'row_value';
	
	$keep_row = $template->getTemplateVars("row");

	// data（検索初期値）は任意
	$row = array();
	if (isset($params['data'])) {
		$row = is_string($params['data']) ? $template->getTemplateVars($params['data']) : $params['data'];
		if (!is_array($row))
			$row = array();
	}

	// --- 1) field_group 直接指定 ---------------
	$group = null;
	if (isset($params['field_group'])) {
		$groupParam = $params['field_group'];
		$group = is_string($groupParam) ? $template->getTemplateVars($groupParam) : $groupParam;
		if (!is_array($group)) {
			trigger_error('{fields_search} "field_group" must resolve to array.', E_USER_WARNING);
			return '';
		}
	}

	// --- 2) db + fields 指定（group 未指定時） ---
	if ($group === null) {
		if (!isset($params['db']) || !isset($params['fields'])) {
			trigger_error('{fields_search} requires either "field_group" or ("db" and "fields").', E_USER_WARNING);
			return '';
		}

		$db = $params['db'];
		$fieldsList = normalize_fields_list_for_fields_search($params['fields']);
		if (empty($fieldsList)) {
			trigger_error('{fields_search} "fields" is empty.', E_USER_WARNING);
			return '';
		}

		// ctl 解決: 引数優先 → テンプレ変数 "_ctl"
		$ctlParam = isset($params['ctl']) ? $params['ctl'] : $template->getTemplateVars('_ctl');
		$ctl = is_string($ctlParam) ? $template->getTemplateVars($ctlParam) : $ctlParam;

		if (!is_object($ctl)) {
			trigger_error('{fields_search} controller not found: pass ctl=... or assign("_ctl", $ctl).', E_USER_WARNING);
			return '';
		}

		if (method_exists($ctl, 'get_field_settings')) {
			$group = $ctl->get_field_settings($db, $fieldsList);
		} elseif (method_exists($ctl, 'assign_field_settings')) {
			$tmpVar = '__tmp_group_' . uniqid();
			$ctl->assign_field_settings($tmpVar, $db, $fieldsList);
			$group = $template->getTemplateVars($tmpVar);
			$template->assign($tmpVar, null);
		} else {
			trigger_error('{fields_search} Neither get_field_settings nor assign_field_settings exists on controller.', E_USER_WARNING);
			return '';
		}

		if (!is_array($group)) {
			trigger_error('{fields_search} resolved field group is not array.', E_USER_WARNING);
			return '';
		}
	}

	// include 先テンプレート
	$file = $baseDir ? rtrim($baseDir, '/') . '/' . $tplName : $tplName;

	// 出力
	$out = '';
	foreach ($group as $field) {
		$paramName = (is_array($field) && isset($field['parameter_name'])) ? (string) $field['parameter_name'] : '';

		// 検索フォームでは required は通常付けないが、
		// __item_search.tpl が判断できるように元データはそのまま渡す
		$template->assign('row', $row);
		$template->assign('field', $field);

		$inner = $template->fetch($file);

		$out .= '<div class="search_form_item '
			. htmlspecialchars($fieldPref, ENT_QUOTES, 'UTF-8')
			. htmlspecialchars($paramName, ENT_QUOTES, 'UTF-8')
			. '">';

		$out .= '<span class="'
			. htmlspecialchars($valueSpanClass, ENT_QUOTES, 'UTF-8')
			. '">'
			. $inner
			. '</span>';

		$out .= '<input type="hidden" name="_field_names[]" value="'
			. htmlspecialchars($paramName, ENT_QUOTES, 'UTF-8')
			. '">';
		
		$out .= '</div>';
	}
	
	//戻す
	$template->assign("row", $keep_row);

	return $out;
}

/**
 * fields を配列へ正規化（PHP 7.3対応）
 * - 配列 → そのまま
 * - JSON 文字列 ["a","b"] → decode
 * - カンマ区切り "a,b,c" → explode + trim + 空除去
 * - 単一文字列 → 1件配列
 */
if (!function_exists('normalize_fields_list_for_fields_search')) {

	function normalize_fields_list_for_fields_search($fields) {
		if (is_array($fields)) {
			return array_values($fields);
		}

		if (is_string($fields)) {
			$s = trim($fields);

			if (strlen($s) > 0 && $s[0] === '[') {
				$arr = json_decode($s, true);
				if (is_array($arr))
					return array_values($arr);
			}

			if (strpos($s, ',') !== false) {
				$arr = array_map('trim', explode(',', $s));
				$arr = array_filter($arr, function ($v) {
					return $v !== '';
				});
				return array_values($arr);
			}

			return array($s);
		}

		return array();
	}

}
