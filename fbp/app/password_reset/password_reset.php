<?php

class password_reset {

	private $ffm_user;

	function __construct(Controller $ctl) {
		$this->ffm_user = $ctl->db("user", "user");
	}

	function page(Controller $ctl) {
		$ctl->show_multi_dialog("password_reset", "form.tpl", "Password Reset", 500, true, true);
	}

	function force_page(Controller $ctl) {
		$user_id = (int) $ctl->get_session("user_id");
		$data = $this->ffm_user->get($user_id);
		$ctl->assign("data", $data);
		$ctl->display("force_page.tpl");
	}

	function reset_exe(Controller $ctl) {
		$password = (string) $ctl->POST("password");
		$password_confirm = (string) $ctl->POST("password_confirm");
		if ($password === "") {
			$ctl->res_error_message("password", "Password is needed.");
			return;
		}
		if ($password !== $password_confirm) {
			$ctl->res_error_message("password_confirm", "Password confirmation does not match.");
			return;
		}

		$user_id = (int) $ctl->get_session("user_id");
		$data = $this->ffm_user->get($user_id);
		if (!is_array($data) || empty($data["id"])) {
			$ctl->res_error_message("password", "User not found.");
			return;
		}

		$data["password"] = $this->hash_password($password);
		if (array_key_exists("flg_password_change_required", $data)) {
			$data["flg_password_change_required"] = 0;
		}
		$this->ffm_user->update($data);
		$ctl->close_multi_dialog("password_reset");
	}

	function force_reset_exe(Controller $ctl) {
		$password = (string) $ctl->POST("password");
		$password_confirm = (string) $ctl->POST("password_confirm");
		if ($password === "") {
			$ctl->assign("err_password", "Password is needed.");
			$this->force_page($ctl);
			return;
		}
		if ($password !== $password_confirm) {
			$ctl->assign("err_password_confirm", "Password confirmation does not match.");
			$this->force_page($ctl);
			return;
		}

		$user_id = (int) $ctl->get_session("user_id");
		$data = $this->ffm_user->get($user_id);
		if (!is_array($data) || empty($data["id"])) {
			$ctl->assign("err_password", "User not found.");
			$this->force_page($ctl);
			return;
		}

		$data["password"] = $this->hash_password($password);
		if (array_key_exists("flg_password_change_required", $data)) {
			$data["flg_password_change_required"] = 0;
		}
		$this->ffm_user->update($data);
		$ctl->res_redirect("app.php?class=base");
	}

	private function hash_password($password) {
		$hash = password_hash((string) $password, PASSWORD_DEFAULT);
		if (!is_string($hash) || $hash === "") {
			throw new Exception("Failed to hash password.");
		}
		return $hash;
	}
}
