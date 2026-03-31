<?php

namespace openai;

// ステータスと、ログを管理

interface StatusManager {

	public function set_status(string $status): void;

	public function get_status(): ?string;
	
}
