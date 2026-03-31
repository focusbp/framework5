<?php

namespace openai;

/**
 * Description of SessionStatusManager
 *
 * @author nakama
 */
class SessionStatusManager implements \openai\StatusManager{
	
	private $windowcode;
	private $vectorStoreName;
	
	public function __construct(string $windowcode, string $vectorStoreName) {
		$this->windowcode = $windowcode;
		$this->vectorStoreName = $vectorStoreName;
	}
	
	public function set_status(string $status): void {
		$_SESSION[$this->windowcode][$this->vectorStoreName]["_status_msg"] = $status;
	}

	public function get_status(): ?string {
		return $_SESSION[$this->windowcode][$this->vectorStoreName]["_status_msg"];
	}
	

}
