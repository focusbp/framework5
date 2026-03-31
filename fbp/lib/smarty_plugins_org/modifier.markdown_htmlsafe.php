<?php
/*
 * Smarty plugin
 * URL to link
 *
 * @param  string $value
 * @param  string $target
 * @return string
 */
function smarty_modifier_markdown_htmlsafe($text) 
{
	include_once(dirname(__FILE__) . "/../../lib_ext/markdown/Parsedown.php");

	$Parsedown = new Parsedown();
	$Parsedown->setSafeMode(true);
	$html = $Parsedown->text($text);
	
	  return $html; 
}