<?php

class embed_app_runtime {

	private $fmt_embed_app;

	function __construct(Controller $ctl) {
		$ctl->set_check_login(false);
		$this->fmt_embed_app = $ctl->db("embed_app", "embed_app");
	}

	function loader_js(Controller $ctl) {
		session_write_close();
		$body = file_get_contents(dirname(__FILE__) . "/Templates/loader.js");
		$this->output($body, "javascript");
		exit;
	}

	function boot(Controller $ctl) {
		// Backward-compatible entry point.
		$this->route($ctl);
	}

	function route(Controller $ctl) {
		$post = $ctl->POST();
		$embed_key = trim((string) ($post["embed_key"] ?? $ctl->GET("embed_key")));
		if ($embed_key === "") {
			$ctl->assign("error", "embed_key is required.");
			$ctl->display("error.tpl");
			return;
		}

		$items = $this->fmt_embed_app->select("embed_key", $embed_key);
		if (count($items) === 0) {
			$ctl->assign("error", "Embed app not found.");
			$ctl->display("error.tpl");
			return;
		}
		$item = $items[0];
		if ((int) ($item["enabled"] ?? 0) !== 1) {
			$ctl->assign("error", "This embed app is disabled.");
			$ctl->display("error.tpl");
			return;
		}

		if (!$this->is_origin_allowed($item, $post)) {
			$ctl->assign("error", "Origin not allowed.");
			$ctl->display("error.tpl");
			return;
		}

		$ctx = [
			"embed_app_id" => $item["id"],
			"embed_key" => $item["embed_key"],
			"class_name" => $item["class_name"],
			"function_name" => "page",
			"origin" => $this->detect_origin($post),
			"loaded_at" => time(),
		];
		$ctl->set_session("embed_app_context", $ctx);

		$target_class = trim((string) ($item["class_name"] ?? ""));
		$target_function = "page";
		if ($target_class === "" || $target_function === "") {
			$ctl->assign("error", "Invalid class/function setting.");
			$ctl->display("error.tpl");
			return;
		}

		$ctl->set_class($target_class);
		$ctl->assign("class", $target_class);
		$ctl->assign("css_class", $target_class);
		$obj = getClassObject($ctl, $target_class, new Dirs());
		if ($obj === null || !is_callable([$obj, $target_function])) {
			$ctl->assign("error", "Target class/function is not callable.");
			$ctl->display("error.tpl");
			return;
		}

		$obj->$target_function($ctl);
	}

	private function detect_origin(array $post): string {
		$origin = trim((string) ($_SERVER['HTTP_ORIGIN'] ?? ''));
		if ($origin !== '') {
			return $origin;
		}

		$referer = trim((string) ($_SERVER['HTTP_REFERER'] ?? ''));
		if ($referer !== '') {
			$parts = parse_url($referer);
			if (!empty($parts['scheme']) && !empty($parts['host'])) {
				return $parts['scheme'] . '://' . $parts['host'];
			}
		}

		return trim((string) ($post['origin'] ?? ''));
	}

	private function is_origin_allowed(array $item, array $post): bool {
		$origin = $this->detect_origin($post);
		$allowed_raw = trim((string) ($item['allowed_origins'] ?? ''));

		if ($allowed_raw === '') {
			return true; // Empty means allow all origins.
		}
		if ($allowed_raw === '*') {
			return true;
		}

		$allowed = [];
		if (substr($allowed_raw, 0, 1) === '[') {
			$arr = json_decode($allowed_raw, true);
			if (is_array($arr)) {
				$allowed = $arr;
			}
		} else {
			$allowed = explode(',', $allowed_raw);
		}

		$normalized = [];
		foreach ($allowed as $v) {
			$v = trim((string) $v);
			if ($v !== '') {
				$normalized[] = rtrim($v, '/');
			}
		}

		if ($origin === '') {
			return false;
		}

		return in_array(rtrim($origin, '/'), $normalized, true);
	}

	private function output($body, $type) {
		$etag = '"' . md5($body) . '"';
		header("Content-Type: text/$type; charset=UTF-8");
		header('X-Content-Type-Options: nosniff');
		header('Cache-Control: public, max-age=86400, immutable');
		header('ETag: ' . $etag);
		echo $body;
	}
}
