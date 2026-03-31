<?php
/*
 * Smarty plugin
 * URL to link
 *
 * @param  string $value
 * @param  string $target
 * @return string
 */
function smarty_modifier_url_link($value,$target="_blank") 
{
    $options = "";
    if ($target == "_blank") {
      $options = sprintf(" target=\"%s\"", $target);
    }

    $value = preg_replace('/((http|https):\/\/[-_.!~*\'()a-zA-Z0-9;\/?:@&=+$,%#]+)/',
                         "<a href=\"\\0\"" . $options . ">\\0</a>", $value); 
    return $value; 
}