<?php

class user {

	private $arr_status = array(0 => "Valid", 1 => "Invalid");
	private $arr_user_type = array(0 => "Admin", 1 => "User");
	private $user_type_opt_colors = array(0=>"#4BA3FF",1=>"#ebb000");
	private $developer_permission_opt = [
	    0 => "Not Allowed",
	    1 => "Developer Permission",
	];

	private $data_manager_permission_opt = [
	    0 => "Not Allowed",
	    1 => "Data Manager Permission",
	];
	private $ffm;
	private $fmt_constant_array;
	private $fmt_values;

	function __construct(Controller $ctl) {
		$ctl->assign("arr_status", $this->arr_status);
		$ctl->assign("user_type_opt",$this->arr_user_type);
		$ctl->assign("user_type_opt_colors",$this->user_type_opt_colors);
		$ctl->assign("developer_permission_opt",$this->developer_permission_opt);
		$ctl->assign("data_manager_permission_opt",$this->data_manager_permission_opt);
		$this->ffm = $ctl->db("user");
		$this->fmt_constant_array = $ctl->db("constant_array","constant_array");
		$this->fmt_values = $ctl->db("values","constant_array");
	}

	function append(Controller $ctl) {

		$ctl->show_multi_dialog("user_add", "append.tpl", "Add User", 800, true, true);
	}

	function append_exe(Controller $ctl) {
		$c = $ctl->POST();
		$c["status"] = 0;
		$c["login_id"] = $c["login_id"];

		$flg = true;

		if (empty($c["login_id"])) {
			$flg = false;
			$ctl->assign("err_login_id", "You needs a loging ID.");
		}

		if (empty($c["password"])) {
			$flg = false;
			$ctl->assign("err_password", "You needs the password.");
		}

		if (!filter_var($c['email'], FILTER_VALIDATE_EMAIL)) {
			$flg = false;
			$ctl->assign("err_email", "Invalid email format.");
		}
			
		//check whether login id is tacken or not
		//重複チェック
		if ($flg) {
			$list = $this->ffm->getall();
			foreach ($list as $d) {
				if ($d["login_id"] == $c["login_id"]) {
					$flg = false;
					$ctl->assign("err_login_id", "You can't user this login id.");
				}
			}
		}

		if ($flg) {
			$plain_password = (string) $c["password"];
			$insert_data = $c;
			$insert_data["password"] = $this->hash_password($plain_password);
			$insert_data["flg_password_change_required"] = 1;
			$this->ffm->insert($insert_data);
			$url = $ctl->get_APP_URL("login","page");
			$ctl->assign("url", $url);
			$ctl->assign("data", $c);
			$ctl->send_mail_prepared_format($c['email'], 'account_created');
			$ctl->close_multi_dialog("user_add");
			$this->page($ctl);
		} else {
			$ctl->assign("data", $ctl->POST());
			$ctl->show_multi_dialog("user_add", "append.tpl", "Add User", 800, true, true);
		}
	}

	function edit(Controller $ctl) {
		$id = $ctl->POST("id");
		$data = $this->ffm->get($id);
		$ctl->assign("data", $data);
		$ctl->show_multi_dialog("user_edit", "edit.tpl", "Edit User", 800, true, true);
	}

	function edit_exe(Controller $ctl) {
		$c = $ctl->POST();
		$flg = true;
		if (!empty($c["email"])) {
			if (!filter_var($c["email"], FILTER_VALIDATE_EMAIL)) {
				$flg = false;
				$ctl->assign("err_email", "Invalid email format.");
			}
		}

		if (!$flg) {
			$ctl->assign("data", $ctl->POST());
			$this->edit($ctl);
			return;
		}

		$id = $ctl->POST("id");
		$data = $this->ffm->get($id);
		foreach ($ctl->POST() as $key => $val) {
			if ($key === "password") {
				continue;
			}
			$data[$key] = $val;
		}
		
		$this->ffm->update($data);

		$ctl->close_multi_dialog("user_edit");
		$this->page($ctl);
	}

	function delete(Controller $ctl) {
		$id = $ctl->POST("id");
		$data = $this->ffm->get($id);
		$ctl->assign("data", $data);
		$ctl->show_multi_dialog("user_delete", "delete.tpl", "Delete User", 800, true, true);
	}

	function delete_exe(Controller $ctl) {
		$id = $ctl->POST("id");
		$this->ffm->delete($id);
		$ctl->close_multi_dialog("user_delete");
		$ctl->ajax("user", "page");
	}

	function passchange(Controller $ctl) {
		$ctl->show_multi_dialog("change_password", "passchange.tpl", "Change Password", 800, true, true);
	}

	function passchange_exe(Controller $ctl) {
		$password = $ctl->POST("password");
		if ((string) $password === "") {
			$ctl->res_error_message("password", "Password is needed.");
			return;
		}
		$d = $this->ffm->get($ctl->get_session("user_id"));
		$d["password"] = $this->hash_password((string) $password);
		if (array_key_exists("flg_password_change_required", $d)) {
			$d["flg_password_change_required"] = 0;
		}
		$this->ffm->update($d);
		$ctl->close_multi_dialog("change_password");
	}

	function password_reset(Controller $ctl) {
		$id = (int) $ctl->POST("id");
		$data = $this->ffm->get($id);
		$ctl->assign("data", $data);
		$ctl->show_multi_dialog("user_password_reset_" . $id, "reset_password.tpl", "Reset Password", 500, true, true);
	}

	function password_reset_exe(Controller $ctl) {
		$id = (int) $ctl->POST("id");
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

		$data = $this->ffm->get($id);
		if (!is_array($data) || empty($data["id"])) {
			$ctl->res_error_message("password", "User not found.");
			return;
		}

		$data["password"] = $this->hash_password($password);
		if (array_key_exists("flg_password_change_required", $data)) {
			$data["flg_password_change_required"] = 0;
		}
		$this->ffm->update($data);
		$ctl->close_multi_dialog("user_password_reset_" . $id);
		$account = [
			"login_id" => $data["login_id"],
			"password" => $password,
			"url" => $ctl->get_APP_URL("login","page"),
		];
		$ctl->assign("data", $account);
		$ctl->show_multi_dialog("account_after_reset_" . $id, "account.tpl", "Account");
	}

	function page(Controller $ctl) {

		$search_word = $ctl->POST("search_word");
		$ctl->assign("search_word", $search_word);
		
		// ajax-auto 
		$max = $ctl->increment_post_value("max", 3);  // increment by 3
		$user_list = $this->ffm->filter(["login_id", "name"], [$search_word, $search_word], false, "OR", "id", SORT_DESC, $max, $is_last);
		$ctl->assign("max", $max);
		$ctl->assign("is_last", $is_last);

		$ctl->assign("user_list", $user_list);
		
		//url
		$login_url = $ctl->get_APP_URL("login","page");
		$ctl->assign("login_url", $login_url);

		$ctl->show_main_area("index.tpl", "User");
	}

	function fr_verification_mail_send(Controller $ctl) {
		$post = $ctl->POST();
		$rand = rand(10000, 99999);
		$body = "Please enter this code and click submit, $rand";
		$subject = "Verify email";
		$ctl->send_mail_string('noreply@focus-business-platform.com', $post['email'], $subject, $body);
		echo json_encode(['key' => $ctl->encrypt($rand)]);
	}

	function fr_verification_mail_verify(Controller $ctl) {
		$post = $ctl->POST();
		$dkey = $ctl->decrypt($post['key']);
		if ($post['code'] == $dkey) {
			echo json_encode(['status' => 1]);
		} else {
			echo json_encode(['status' => 0]);
		}
	}
	
	function image_sample(Controller $ctl){
		$ctl->res_image("images", "sample.png");
	}
	
	function upload_csv(Controller $ctl) {
		$post = $ctl->POST();
		$ctl->assign('post', $post);
		$code_list = ["UTF-8"=>"UTF-8(Exported from Google SpreadSheet/Mac)","win"=>"SJIS-win(Exported from Windows Excel)"];
		$ctl->assign("code_list",$code_list);
		$ctl->show_multi_dialog("upload_csv", "upload_csv.tpl", "Upload CSV", 800);
	}
	
	
	function upload_csv_confirm(Controller $ctl){
		
		if (!$ctl->is_posted_file("users_csv")){
			if (empty($post["users_csv"])){
				$errors["users_csv"] = "必須項目です";
			}
			$ctl->assign("errors",$errors);
			$this->upload_csv($ctl);
			return;
		}
		
		$ctl->save_posted_file("users_csv", "users_csv.csv");
		$filepath = $ctl->get_saved_filepath("users_csv.csv");

		//open saved file
		$fp = fopen($filepath,"r");

		//set encoding for japanese
		if($ctl->POST("code") == "win"){
			stream_filter_register("convert.mbstring.*", "Stream_Filter_Mbstring");
			$filter_name = 'convert.mbstring.encoding.SJIS-win:UTF-8';
			stream_filter_append($fp, $filter_name, STREAM_FILTER_READ);
		}

		

		//read each line as csv
		$first = true;
		$list = [];
		$next_flg=true;
		while ($row = fgetcsv($fp)){
			
			$errors = [];
			
			if ($first){
				$first = false;
				continue;
			}

			if (empty($row[0])){
				$errors[] = "Name is empty";
			}
			if (empty($row[1])){
				$errors[] = "Email is empty";
			}
			if (!filter_var($row[1], FILTER_VALIDATE_EMAIL)){
				$errors[] = "Incorrect email format";
			}
			$users = $this->ffm->select(["login_id"], [$row[1]], true);
			if(count($users) > 0){
				$errors[] = "Email is duplicated";
			}
			
			$rec = [
			    "errors" => $errors,
			    "name" => $row[0],
			    "email" => $row[1],
			    "password" => rand(111111, 999999)
			];
			
			if(count($errors)>0){
				$next_flg=false;
			}

			$list[] = $rec;


		}
		
		$ctl->set_session("userlist", $list);
		$ctl->assign("list",$list);
		$ctl->assign("next_flg",$next_flg);
		
		$ctl->show_multi_dialog("upload_csv", "upload_confirm.tpl", "Upload CSV", 800);

		fclose($fp);
	}
	
	
	function upload_csv_exe(Controller $ctl) {
		
		
		$list = $ctl->get_session("userlist");

		foreach($list as $rec){
			$plain_password = (string) $rec["password"];
			$insert_data=[
				'name'=>$rec["name"],
				'email'=>$rec["email"],
				'status' => 0,
				'login_id' => $rec["email"],
				'password' => $this->hash_password($plain_password),
				'flg_password_change_required' => 1,
				'type' => 1, //member
				'date_join' => date('Y/m/d'),
				'created_at' => time()
			];
			$this->ffm->insert($insert_data);

			try{
				$setting = $ctl->get_setting();
				$mail_data = $insert_data;
				$mail_data["password"] = $plain_password;
				$ctl->assign("data", $mail_data);
				$url = $ctl->get_APP_URL("login","page");
				$ctl->assign("url", $url);
				$ctl->assign("setting", $setting);
				$ctl->send_mail_prepared_format($insert_data['email'], 'account_created');
			}catch(Exception $e){
				echo $e;
			}
		}
		
		$ctl->assign("count",count($list));
		$ctl->show_multi_dialog("upload_csv", "upload_finish.tpl", "Upload CSV", 800);
		$ctl->ajax("user","page");
	}

	private function hash_password($password) {
		$hash = password_hash((string) $password, PASSWORD_DEFAULT);
		if (!is_string($hash) || $hash === "") {
			throw new Exception("Failed to hash password.");
		}
		return $hash;
	}

	private function current_origin() {
		if (!empty($_SERVER["HTTP_ORIGIN"])) {
			return (string) $_SERVER["HTTP_ORIGIN"];
		}
		$scheme = (!empty($_SERVER["HTTPS"]) && $_SERVER["HTTPS"] !== "off") ? "https://" : "http://";
		$host = $_SERVER["HTTP_HOST"] ?? "";
		return $scheme . $host;
	}
}
