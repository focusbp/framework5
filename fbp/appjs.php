<?php
ini_set('display_errors',1);
error_reporting(E_ALL & ~E_NOTICE);

header('Content-Type: text/javascript');
header("Cache-Control:no-cache,no-store,must-revalidate,max-age=0");
header("Cache-Control: post-check=0, pre-check=0", false);
header("Pragma:no-cache");

$class = $_GET["class"];

include("lib/Dirs.php");
$dir = new Dirs();

$file = $dir->get_class_dir($class) . "/script.js";

if(is_file($file)){
	$js = file_get_contents($file);
	$js = str_replace("append_function_dialog(","append_function_dialog(\"" .$class . "\",",$js);
	echo $js;
}
