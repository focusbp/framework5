# Line Bot Member Link Patterns

`app-miclub` を参考にした、LINE Bot 会員連携の再現パターン。

## 1. 基本構成

LINE 連携は次の2段階で考える。

1. `getting_member`
   - LINE の `userId` から会員DBを解決する
   - 未登録なら必要に応じて新規作成する
   - 解決結果を `line_webhook_context.line_member` に載せる
2. 個別ルール
   - `keyword=イベント` のような `exact` ルール
   - `line_member` を使って個別 URL やメッセージを返す

標準構成:
- テーブル名: `line_member`
- LINE user_id 保存フィールド: `userid`
- 表示名保存フィールド: `line_name`
- 名前保存フィールド: `name`

Wizard 運用ルール:
- `LINE用会員データベース作製` は上記固定テンプレートで作る。
- `Line Bot処理追加` / `Line Bot処理変更` で会員連携を前提にする場合も、上記固定構成を標準とする。

設計ルール:
- `webhook_rule` のクラスと公開側の画面クラスは分離する。
- `webhook_rule` 側は入口として URL 返却や簡単な返信に集中させる。
- 画面表示・フォーム処理・DB更新は `public_pages` 側に置く。
- 管理しやすさは同一クラス化ではなく、対応ペアの命名規約で担保する。

命名規約の例:
- `line_webhook_rule_event` -> `public_pages::event_list`
- `line_webhook_rule_member_search` -> `public_pages::member_search`
- `line_webhook_rule_profile_edit` -> `public_pages::profile_edit`

## 2. webhook_rule の典型形

### getting_member

```json
{
  "channel": "0",
  "keyword": "[getting_member]",
  "match_type": "data_type",
  "action_class": "line_webhook_rule_getting_member",
  "enabled": 1
}
```

### 友達追加

```json
{
  "channel": "0",
  "keyword": "[follow]",
  "match_type": "data_type",
  "action_class": "line_webhook_rule_follow",
  "enabled": 1
}
```

### キーワード処理

```json
{
  "channel": "0",
  "keyword": "イベント",
  "match_type": "exact",
  "action_class": "line_webhook_rule_event",
  "enabled": 1
}
```

## 3. getting_member のサンプル

`app-miclub` では `line_member.userid = LINE userId` で会員を解決している。

```php
<?php

class line_webhook_rule_getting_member {
	function run(Controller $ctl) {
		$context = (array)($ctl->get_session("line_webhook_context") ?? []);
		$userid = trim((string)($context["userid"] ?? ""));
		if ($userid === "") {
			return null;
		}
		$displayname = trim((string)($context["displayname"] ?? ""));

		$list = $ctl->db("line_member")->select("userid", $userid);
		if (count($list) > 0) {
			return ["line_member" => $list[0], "handled" => true];
		}

		$d = [];
		$d["line_name"] = $displayname;
		$d["userid"] = $userid;
		$d["name"] = $displayname;
		$id = (int)$ctl->db("line_member")->insert($d);
		$line_member = $ctl->db("line_member")->get($id);
		if (empty($line_member)) {
			return null;
		}

		return ["line_member" => $line_member, "handled" => true];
	}
}
```

使い方:
- `userid` 保存フィールド: `userid`
- 表示名保存フィールド: `line_name`
- 名前保存フィールド: `name`
- 未登録時は新規作成

## 4. 友達追加のサンプル

```php
<?php

class line_webhook_rule_follow {
	function run(Controller $ctl) {
		$context = (array)($ctl->get_session("line_webhook_context") ?? []);
		$displayname = trim((string)($context["displayname"] ?? ""));

		$setting = $ctl->get_setting();
		$greeting_message = trim((string)($setting["line_bot_greeting_message"] ?? ""));
		if ($displayname !== "") {
			$message = "友だち追加ありがとうございます！ " . $displayname . " さん、よろしくお願いします。";
			if ($greeting_message !== "") {
				$message .= "\n\n" . $greeting_message;
			}
		} else {
			$message = "友だち追加ありがとうございます！";
		}

		return [
			"reply_text" => $message,
			"handled" => true,
		];
	}
}
```

ポイント:
- `keyword` は `[follow]`
- `match_type` は `data_type`
- `displayname` は `line_webhook_context` から取得

## 5. 会員連携済みキーワード処理のサンプル

### URL返信型

```php
<?php

class line_webhook_rule_event {
	function run(Controller $ctl) {
		$context = (array)($ctl->get_session("line_webhook_context") ?? []);
		$line_member = (array)($context["line_member"] ?? []);
		$id = (int)($line_member["id"] ?? 0);
		if ($id <= 0) {
			return ["handled" => false];
		}
		$id_enc = $ctl->encrypt($id);
		$url = $ctl->get_APP_URL("public_pages", "event_list", ["id" => $id_enc]);
		return [
			"reply_text" => "下記のURLからイベントの確認・お申し込みください。\n" . $url,
			"handled" => true,
		];
	}
}
```

### 会員検索

```php
<?php

class line_webhook_rule_member_search {
	function run(Controller $ctl) {
		$context = (array)($ctl->get_session("line_webhook_context") ?? []);
		$line_member = (array)($context["line_member"] ?? []);
		$id = (int)($line_member["id"] ?? 0);
		if ($id <= 0) {
			return ["handled" => false];
		}
		$id_enc = $ctl->encrypt($id);
		$url = $ctl->get_APP_URL("public_pages", "member_search", ["id" => $id_enc]);
		return [
			"reply_text" => "下記のURLから会員検索ができます。\n" . $url,
			"handled" => true,
		];
	}
}
```

### プロフィール編集

```php
<?php

class line_webhook_rule_profile_edit {
	function run(Controller $ctl) {
		$context = (array)($ctl->get_session("line_webhook_context") ?? []);
		$line_member = (array)($context["line_member"] ?? []);
		$id = (int)($line_member["id"] ?? 0);
		if ($id <= 0) {
			return ["handled" => false];
		}
		$id_enc = $ctl->encrypt($id);
		$url = $ctl->get_APP_URL("public_pages", "profile_edit", ["id" => $id_enc]);
		return [
			"reply_text" => "下記のURLからプロフィールを編集できます。\n" . $url,
			"handled" => true,
		];
	}
}
```

## 6. 生成時の必須指定

`getting_member` を安定生成するには、次を明示する。

- 対象テーブル
- LINE user_id 保存フィールド
- 表示名保存フィールド
- 名前保存フィールド
- 未登録時の新規作成可否

例:

```text
対象テーブル: line_member
LINE user_id 保存フィールド: userid
表示名保存フィールド: line_name
名前保存フィールド: name
未登録時: 新規作成する
```

Wizard 固定テンプレートでは、上記指定は明示済みとして扱ってよい。

## 7. 実装時の注意

- `getting_member` は内部フックなので、通常のキーワード処理とは別に先に用意する。
- `line_member` が取れない場合は `handled => false` を返すか、`null` を返す。
- URL は文字列連結せず、`$ctl->get_APP_URL()` を使う。
- `channel + keyword` 重複を避ける。
