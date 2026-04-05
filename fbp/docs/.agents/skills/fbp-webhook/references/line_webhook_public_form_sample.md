# line_webhook_public_form_sample

LINE webhook から公開フォームへ誘導し、公開側で常に `line_member` を引けるようにする基本形。

## intent
- webhook の action_class は公開URLを返すだけにする
- `userid` は暗号化して公開URLへ渡す
- `public_pages` 側では各関数で `userid` を復号し、毎回 `line_member` を取得する
- `show_public_pages()` の `contents_header` / `contents_footer` 差し込みも併用できる形にする
- 完了画面も `show_public_pages()` にそろえる

## action_class sample

```php
<?php

class line_webhook_rule_inquiry_entry {

	function run(Controller $ctl) {
		$context = $ctl->get_session("line_webhook_context");
		$userid = trim((string) ($context["userid"] ?? ""));
		if ($userid === "") {
			return "ユーザー情報を取得できませんでした。";
		}

		return $ctl->get_APP_URL("public_pages", "line_inquiry", [
			"userid" => $ctl->encrypt($userid),
		]);
	}
}
```

## public_pages sample

```php
<?php

class public_pages {

	function __construct(Controller $ctl) {
		$ctl->set_check_login(false);
	}

	function line_inquiry(Controller $ctl) {
		$line_member = $this->require_line_member($ctl);
		if ($line_member === null) {
			return;
		}
		$userid_enc = trim((string) ($ctl->POST("userid") ?: $ctl->GET("userid")));
		if ($userid_enc !== "") {
			$ctl->set_session("line_inquiry_userid", $userid_enc);
		}
		$ctl->assign("line_member", $line_member);
		$ctl->assign("row", [
			"userid" => $userid_enc,
			"name" => trim((string) ($line_member["name"] ?? "")),
			"message" => "",
		]);
		$ctl->assign("page_title", "LINE お問い合わせ");
		$ctl->show_public_pages(
			"line_inquiry.tpl",
			null,
			"line_inquiry_header.tpl",
			"line_inquiry_footer.tpl"
		);
	}

	function line_inquiry_exe(Controller $ctl) {
		$line_member = $this->require_line_member($ctl);
		if ($line_member === null) {
			return;
		}
		$post = $ctl->POST();
		$row = [
			"userid" => trim((string) ($post["userid"] ?? "")),
			"name" => trim((string) ($post["name"] ?? "")),
			"message" => trim((string) ($post["message"] ?? "")),
		];

		if ($row["name"] === "") {
			$ctl->res_error_message("name", "名前を入力してください。");
			return;
		}
		if ($row["message"] === "") {
			$ctl->res_error_message("message", "内容を入力してください。");
			return;
		}

		$ctl->db("contact_inquiry")->insert([
			"userid" => trim((string) ($line_member["userid"] ?? "")),
			"name" => $row["name"],
			"message" => $row["message"],
		]);

		$ctl->assign("line_member", $line_member);
		$ctl->assign("saved", $row);
		$ctl->assign("line_inquiry_url", $ctl->get_APP_URL("public_pages", "line_inquiry"));
		$ctl->assign("page_title", "送信ありがとうございました");
		$ctl->show_public_pages(
			"line_inquiry_done.tpl",
			null,
			"line_inquiry_header.tpl",
			"line_inquiry_footer.tpl"
		);
	}

	private function require_line_member(Controller $ctl): ?array {
		$userid_enc = trim((string) ($ctl->POST("userid") ?: $ctl->GET("userid")));
		if ($userid_enc === "") {
			$userid_enc = trim((string) ($ctl->get_session("line_inquiry_userid") ?? ""));
		}
		if ($userid_enc !== "") {
			$ctl->set_session("line_inquiry_userid", $userid_enc);
		}
		$userid = trim((string) $ctl->decrypt($userid_enc));
		if ($userid === "") {
			$ctl->assign("page_title", "LINE会員情報が見つかりません");
			$ctl->show_public_pages("line_inquiry_error.tpl");
			return null;
		}

		$list = $ctl->db("line_member")->select("userid", $userid);
		if (!is_array($list) || count($list) === 0) {
			$ctl->assign("page_title", "LINE会員情報が見つかりません");
			$ctl->show_public_pages("line_inquiry_error.tpl");
			return null;
		}
		return (array) $list[0];
	}
}
```

## template sample

```smarty
<form id="line_inquiry_form" onsubmit="return false;">
	<input type="hidden" name="userid" value="{$row.userid|escape}">

	<input type="text" name="name" value="{$row.name|escape}">
	<p class="error_message error_name"></p>

	<textarea name="message">{$row.message|escape}</textarea>
	<p class="error_message error_message"></p>

	<button class="ajax-link" data-class="{$class}" data-function="line_inquiry_exe" data-form="line_inquiry_form">送信する</button>
</form>
```

## notes
- `userid` は暗号化済みの値を URL と hidden に持たせる。
- `public_pages` の各関数で `require_line_member()` を呼べば、いつでも同じコードで `line_member` を取得できる。
- `line_member` を session から読む前提にせず、`userid` から再解決する形を優先する。
- `getone()` ではなく `select("userid", $userid)` の既存パターンに合わせる。
- `続けて入力する` のような戻りリンクは、session に保持した暗号化済み `userid` を再利用し、URL パラメータを省略するほうが安定する。
