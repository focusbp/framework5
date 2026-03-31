<?php

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Scripting/PHPInterface.php to edit this template
 */

/**
 *
 * @author nakama
 */
interface Vimeo {
	
	function upload($download_url,$file_size=null);
	
	function edit($vimeo_id, $title, $description):bool;
	
	function delete($vimeo_id):bool;
	
	function get_error():string;
}
