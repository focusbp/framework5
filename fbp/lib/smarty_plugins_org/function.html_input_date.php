<?php

function smarty_function_html_input_date($params, Smarty_Internal_Template $template)
{
    $template->_checkPlugins(
        array(
            array(
                'function' => 'smarty_function_escape_special_chars',
                'file'     => SMARTY_PLUGINS_DIR . 'shared.escape_special_chars.php'
            )
        )
    );
    $value = null;
    $extra = '';
	$params["type"] = "text";
	$params["class"] = "datepicker";
	$params["data-strtotime"] = "1";
    foreach ($params as $_key => $_val) {
        switch ($_key) {
            case 'value':
                $value = $_val;
                break;
            default:
                if (!is_array($_val)) {
                    $extra .= ' ' . $_key . '="' . smarty_function_escape_special_chars($_val) . '"';
                } else {
                    trigger_error("html_options: extra attribute '{$_key}' cannot be an array", E_USER_NOTICE);
                }
                break;
        }
    }
	
	if(empty($value)){
		$str = "";
	}else{
		$str = date("Y/m/d",$value);
	}
	
	$_html_result = "<input $extra value=\"$str\">"; 

    return $_html_result;
}
