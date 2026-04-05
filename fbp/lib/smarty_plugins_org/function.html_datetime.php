<?php

function smarty_function_html_datetime($params, Smarty_Internal_Template $template)
{
    $value = $params['value'] ?? null;
    if (empty($value) || !is_numeric($value)) {
        return '';
    }

    $setting = $template->getTemplateVars("setting");
    $timezone = !empty($setting["timezone"]) ? (string) $setting["timezone"] : date_default_timezone_get();
    $datetime_format = !empty($setting["datetime_format"]) ? (string) $setting["datetime_format"] : "Y/m/d H:i";

    $moto = date_default_timezone_get();
    date_default_timezone_set($timezone);
    $formatted = date($datetime_format, (int) $value);
    date_default_timezone_set($moto);

    return $formatted;
}
