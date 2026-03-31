<?php

/**
 * Smarty plugin
 *
 * @package    Smarty
 * @subpackage PluginsModifierCompiler
 */
/**
 * Smarty escape_nl modifier plugin
 * Type:     modifier
 * Name:     escape_nl
 * Purpose:  replace newline characters "\n" with '\n' in a string
 *
 * @param array $params parameters
 *
 * @return string with compiled code
 */
function smarty_modifier_escape_nl($params) {
    return str_replace("\n", '\n', (string)$params);
}