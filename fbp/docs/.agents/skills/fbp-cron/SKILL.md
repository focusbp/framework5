---
name: fbp-cron
description: Manage scheduled jobs with cron_list/add/edit/delete and verify periodic execution paths.
---

# fbp-cron

## trigger conditions
- 定期実行ジョブを追加・変更・削除する
- `cron` 登録内容の棚卸しが必要

## workflow
1. `cron_list` で既存ジョブ確認。
2. `cron_add` / `cron_edit` / `cron_delete` を実施。
3. 対象処理を手動実行相当で検証し、副作用を確認。

## registration format
- 詳細は `references/cron_registration.md` を参照。
- `cron` は `cron_expression` ではなく、`min / hour / day / month / weekday` の配列項目で登録する。
- 実行対象は `class_name + function_name` で決まる。
- 定義反映後は `cron_set()` が必要。

## constraints
- 本番影響のある時刻指定は安全側で設定し、重複起動を避ける。
