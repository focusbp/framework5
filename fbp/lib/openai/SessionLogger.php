<?php

namespace openai;

/**
 * Description of SessionLogger
 *
 * @author nakama
 */
class SessionLogger implements Logger {
	
	private $windowcode;
	private $vectorStoreName;

	/**
	 * @param string $windowcode
	 * @param string $vectorStoreName
	 */
	public function __construct(string $windowcode, string $vectorStoreName) {
		$this->windowcode = $windowcode;
		$this->vectorStoreName = $vectorStoreName;
	}
	
	public function add_log($text){
		$_SESSION[$this->windowcode][$this->vectorStoreName]['_log'] .= $text;
	}
	
	public function get_log(){
		return $_SESSION[$this->windowcode][$this->vectorStoreName]['_log'];
	}
	
	public function clear_log(){
		if (session_status() === PHP_SESSION_ACTIVE) {
			$flg=true;
		}
		if(!$flg){
			session_start();
		}
		$_SESSION[$this->windowcode][$this->vectorStoreName]['_log'] = "";
		if(!$flg){
			session_write_close();
		}
	}
}
