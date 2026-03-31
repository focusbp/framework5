<?php


namespace openai;

/**
 *
 * @author nakama
 */
interface Logger {

	public function add_log($text);
	
	public function get_log();
	
	public function clear_log();
	
}
