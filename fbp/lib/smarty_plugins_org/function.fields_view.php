<?php

/**
 * {fields_view
 *    field_group="group1"                 // 既存互換: フィールド定義配列 or そのテンプレ変数名
 *    db="line_member"                     // 新: DB/モデル名等
 *    fields=["name","furigana",...]       // 新: 項目名配列（Smarty配列/JSON/カンマ区切り対応）
 *    data="event"                         // 表示する行データ（配列 or 変数名）
 *    ctl=$myCtl                           // 任意: コントローラ。省略時はテンプレ変数 "_ctl" を参照
 *    template="__item_viewer.tpl"
 *    base_template_dir=$base_template_dir
 *    field_class_prefix="field_"          // 外側 <div> の接頭辞 => "field_{$parameter_name}"
 *    value_span_class="row_value"         // 値を包む <span> のクラス
 * }
 */
function smarty_function_fields_view(array $params, Smarty_Internal_Template $template) {
	$tplName = isset($params['template']) ? $params['template'] : '__item_viewer.tpl';
	
	$notag=false;
	if(isset($params["notag"]) && $params["notag"]=="true"){
		$tplName = "__item_viewer_notag.tpl";
		$notag = true;
	}
	
	$baseDir = isset($params['base_template_dir']) ? $params['base_template_dir'] : ($template->getTemplateVars('base_template_dir') ?: '');

	$fieldPref = isset($params['field_class_prefix']) ? $params['field_class_prefix'] : 'field_';
	$valueClass = isset($params['value_span_class']) ? $params['value_span_class'] : 'row_value';
	$showTitle = true; // default true

	if (array_key_exists('show_title', $params)) {
		$v = $params['show_title'];

		if (is_bool($v)) {
			$showTitle = $v;
		} else {
			$s = strtolower(trim((string) $v));
			// "false" を含め、代表的な false 値を false 扱い
			$showTitle = !in_array($s, ['0', 'false', 'off', 'no', 'null', ''], true);
		}
	}
	$wrapperTag = isset($params['wrapper_tag']) ? strtolower($params['wrapper_tag']) : 'div'; // 'div' | 'td' | 'span' 等
	$wrapperClass = isset($params['wrapper_class']) ? $params['wrapper_class'] : null;

	// data は必須
	if (!isset($params['data'])) {
		trigger_error('{fields_view} requires "data" parameter.', E_USER_WARNING);
		return '';
	}
	
	$keep_row = $template->getTemplateVars("row");
	$row = is_string($params['data']) ? $template->getTemplateVars($params['data']) : $params['data'];

	// --- 1) field_group 直接指定 ---------------
	$group = null;
	if (isset($params['field_group'])) {
		$groupParam = $params['field_group'];
		$group = is_string($groupParam) ? $template->getTemplateVars($groupParam) : $groupParam;
		if (!is_array($group)) {
			trigger_error('{fields_view} "field_group" must resolve to array.', E_USER_WARNING);
			return '';
		}
	}

	// --- 2) db + fields 指定（group 未指定時） ---
	if ($group === null) {
		if (!isset($params['db']) || !isset($params['fields'])) {
			trigger_error('{fields_view} requires either "field_group" or ("db" and "fields").', E_USER_WARNING);
			return '';
		}

		$db = $params['db'];
		$fieldsList = normalize_fields_list_for_fields_view($params['fields']);
		if (empty($fieldsList)) {
			trigger_error('{fields_view} "fields" is empty.', E_USER_WARNING);
			return '';
		}

		// ctl 解決: 引数優先 → テンプレ変数 "_ctl"
		$ctlParam = isset($params['ctl']) ? $params['ctl'] : $template->getTemplateVars('_ctl');
		$ctl = is_string($ctlParam) ? $template->getTemplateVars($ctlParam) : $ctlParam;

		if (!is_object($ctl)) {
			trigger_error('{fields_view} controller not found: pass ctl=... or assign("_ctl", $ctl).', E_USER_WARNING);
			return '';
		}

		// コントローラからフィールド定義を取得
		if (method_exists($ctl, 'get_field_settings')) {
			$group = $ctl->get_field_settings($db, $fieldsList);
		} elseif (method_exists($ctl, 'assign_field_settings')) {
			// 既存の assign_* 型のみの場合のフォールバック
			$tmpVar = '__tmp_group_' . uniqid();
			$ctl->assign_field_settings($tmpVar, $db, $fieldsList);
			$group = $template->getTemplateVars($tmpVar);
			$template->assign($tmpVar, null); // 後始末
		} else {
			trigger_error('{fields_view} Neither get_field_settings nor assign_field_settings exists on controller.', E_USER_WARNING);
			return '';
		}

		if (!is_array($group)) {
			trigger_error('{fields_view} resolved field group is not array.', E_USER_WARNING);
			return '';
		}
	}

	// include テンプレートの実体パス
	$file = $baseDir ? rtrim($baseDir, '/') . '/' . $tplName : $tplName;

	// 出力構築
	$out = '';
	foreach ($group as $field) {
		$paramName = (is_array($field) && isset($field['parameter_name'])) ? (string) $field['parameter_name'] : '';
		$paramTitle = (is_array($field) && isset($field['parameter_title'])) ? (string) $field['parameter_title'] : '';

		$template->assign('row', $row);
		$template->assign('field', $field);

		$inner = $template->fetch($file);

		// ★ラッパーの class を決定
		if ($wrapperClass !== null && $wrapperClass !== '') {
			$outerClass = $wrapperClass; // 明示指定があればそれを優先
		} else {
			$outerClass = $fieldPref . $paramName; // 既存互換: "field_param"
		}

		if($notag == false){
			// ★開始タグ
			$out .= '<' . htmlspecialchars($wrapperTag, ENT_QUOTES, 'UTF-8') . ' class="'
				. htmlspecialchars($outerClass, ENT_QUOTES, 'UTF-8') . '">';

			// タイトル
			if ($showTitle && $paramTitle !== '') {
				$out .= '<span class="row_title">'
					. htmlspecialchars($paramTitle, ENT_QUOTES, 'UTF-8')
					. '</span>';
			}

			// 値
			$out .= '<span class="' . htmlspecialchars($valueClass, ENT_QUOTES, 'UTF-8') . '">'
				. $inner
				. '</span>';

			// ★終了タグ
			$out .= '</' . htmlspecialchars($wrapperTag, ENT_QUOTES, 'UTF-8') . '>';
		}else{
			$out .= $inner;
		}
		
		//戻す
		$template->assign("row",$keep_row);
	}

	return $out;
}

/**
 * fields パラメータを配列へ正規化（PHP 7.3対応）
 * - 既に配列 → そのまま
 * - JSON 文字列 ["a","b"] → decode
 * - カンマ区切り "a,b,c" → explode + trim + 空要素除去
 * - 単一文字列 → 1件配列
 */
if (!function_exists('normalize_fields_list_for_fields_view')) {

	function normalize_fields_list_for_fields_view($fields) {
		if (is_array($fields)) {
			return array_values($fields);
		}

		if (is_string($fields)) {
			$s = trim($fields);

			// JSON っぽいなら decode
			if (strlen($s) > 0 && $s[0] === '[') {
				$arr = json_decode($s, true);
				if (is_array($arr)) {
					return array_values($arr);
				}
			}

			// カンマ区切り
			if (strpos($s, ',') !== false) {
				$arr = array_map('trim', explode(',', $s));
				// PHP 7.3: 無名関数で空文字除去
				$arr = array_filter($arr, function ($v) {
					return $v !== '';
				});
				return array_values($arr);
			}

			// 単一要素
			return array($s);
		}

		return array();
	}

}
