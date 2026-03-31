---
name: fbp-square-payment
description: Implement Square Payment flows in FBP using show_square_dialog and callback-based payment execution.
---

# fbp-square-payment

## trigger conditions
- `db_additionals` で `code_type=Square Payment` を追加する
- `show_square_dialog()` を使ったカード決済を実装する
- Square決済の成否ダイアログを実装・検証する

## workflow
1. 決済クラスの `run()` で `show_square_dialog("<class>", "pay", $callback_params)` を呼ぶ。
2. `pay()` で `get_square_callback_parameter_array()` を取得し、`square_regist_customer()` -> `square_regist_card()` -> `square_payment()` を順に実行する。
3. 成否で `close_square_dialog()` 後に `show_multi_dialog()` を返す。
4. 例外時は `show_square_dialog()` を再表示し、エラーメッセージを返す。
5. `db_additionals_add` で `code_type:[5]` を設定し、対象テーブルにボタン導線を追加する。

## constraints
- 秘密鍵/アクセストークンをコード直書きしない（`setting` 利用）。
- 最低限の金額バリデーション（0以下不可）を入れる。
- `run()` で受け取る `id` は暗号化IDとして扱い、`decrypt()` 後に利用する。
