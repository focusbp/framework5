<?php

include "src/HeicToJpg.php";

$HeicToJpg = new Maestroerror\HeicToJpg();
$HeicToJpg->convert("image1.heic")->saveAs("jpg-from-php.jpg");

//Maestroerror\HeicToJpg::convert("image1.heic")->saveAs("jpg-from-php.jpg");