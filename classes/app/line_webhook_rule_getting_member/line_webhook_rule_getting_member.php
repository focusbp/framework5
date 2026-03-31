<?php

class line_webhook_rule_getting_member {

	function run(Controller $ctl) {
		$context = (array) ($ctl->get_session("line_webhook_context") ?? []);
		$userid = trim((string) ($context["userid"] ?? ""));
		if ($userid === "") {
			return null;
		}

		$displayname = trim((string) ($context["displayname"] ?? ""));
		$db = $ctl->db("line_member");
		$list = $db->select("userid", $userid);
		if (!empty($list)) {
			$line_member = $list[0];
			$updated = false;
			$current_line_name = trim((string) ($line_member["line_name"] ?? ""));
			$current_name = trim((string) ($line_member["name"] ?? ""));

			if ($displayname !== "" && $current_line_name !== $displayname) {
				$line_member["line_name"] = $displayname;
				$updated = true;
			}
			if ($displayname !== "" && ($current_name === "" || $current_name === $current_line_name)) {
				$line_member["name"] = $displayname;
				$updated = true;
			}
			if ($updated) {
				$db->update($line_member);
				$line_member = $db->get((int) ($line_member["id"] ?? 0));
			}

			return [
				"line_member" => $line_member,
				"handled" => true,
			];
		}

		$insert = [
			"userid" => $userid,
			"line_name" => $displayname,
			"name" => $displayname,
		];
		$id = (int) $db->insert($insert);
		if ($id <= 0) {
			return null;
		}

		$line_member = $db->get($id);
		if (empty($line_member)) {
			return null;
		}

		return [
			"line_member" => $line_member,
			"handled" => true,
		];
	}
}
