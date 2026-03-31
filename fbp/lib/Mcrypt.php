<?php

class Mcrypt {

	private $METHOD = 'AES-256-CBC';
	private $options = 0;
	private $SECRET;
	private $iv;

	function __construct($secret, $iv) {
		if (empty($secret) || empty($iv)) {
			throw new Exception("Mcrypt requires secret and iv.");
		}
		$this->SECRET = $secret;
		$iv = (string) $iv;
		if (strlen($iv) > 16) {
			$iv = substr($iv, 0, 16);
		}
		if (strlen($iv) < 16) {
			$iv = str_pad($iv, 16, "0");
		}
		$this->iv = $iv;
	}

	public function encrypt($input) {
		$encrypted = openssl_encrypt($input, $this->METHOD, $this->SECRET, $this->options, $this->iv);
		$base64 = base64_encode($encrypted);
		return urlencode($base64);
	}

	public function decrypt($encrypted) {
		$urldecode = urldecode($encrypted);
		$base64 = base64_decode($urldecode);
		$decrypted = openssl_decrypt($base64, $this->METHOD, $this->SECRET, $this->options, $this->iv);
		return $decrypted;
	}
}
