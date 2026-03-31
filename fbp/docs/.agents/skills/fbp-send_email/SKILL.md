---
name: fbp-send_email
description: Configure email_format templates and implement prepared-format email sending flows.
---

# fbp-send_email

## trigger conditions
- テンプレートメール送信を実装する
- `email_format` の追加・編集や置換検証が必要
- `send_mail_prepared_format` を扱う

## workflow
1. `email_format` を作成または更新。
2. 置換キーを検証。
3. 送信処理から `send_mail_prepared_format` を呼び出す。
4. テスト送信で件名・本文・宛先を確認。

## constraints
- 実運用アドレスへの誤送信を防ぐため、検証環境では宛先を固定化する。
