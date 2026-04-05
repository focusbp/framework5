<?php

function smarty_function_html_display_value($params, Smarty_Internal_Template $template)
{
    $value = $params['value'] ?? null;
    $field = $params['field'] ?? [];
    if (!is_array($field)) {
        $field = [];
    }

    $setting = $template->getTemplateVars("setting");
    if (!is_array($setting)) {
        $setting = [];
    }

    $formatter = new ValueFormatter($setting);
    return $formatter->format_for_field($field, $value);
}
