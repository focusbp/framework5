---
name: fbp-csv-media
description: Implement and verify CSV upload/download and file/image field flows in FBP.
---

# fbp-csv-media

## trigger conditions
- CSVアップロード/ダウンロード機能を追加・修正する
- `type=file` / `type=image` の保存・表示導線を作る
- CLIで `app_call` の `files` を使ってアップロード検証したい

## workflow
1. DB側に `file` / `image` フィールドを追加し、`screen_fields` を `list/add/edit/delete` へ反映する。
2. CSVダウンロードは `res_csv()` でヘッダ行 + データ行を返す。
3. CSVアップロードは `fields_form_original type="file"` + `upload_exe` で実装し、`res_error_message()` で入力エラーを返して即 `return` する。
4. file/imageは保存時に `save_files()` or `save_posted_files()` を使う（DB標準画面なら自動保存）。
5. `app_call` でCSV出力/アップロードを検証し、`data_list` で反映確認する。

## cli checks
- CSV出力:
  - `php cli.php app_call --json='{"class":"<class>","function":"csv_download","post":{"encode":"UTF-8"},"output_file":"/tmp/out.csv"}'`
- CSVアップロード:
  - `php cli.php app_call --json='{"class":"<class>","function":"upload_exe","files":{"file":{"path":"/tmp/in.csv","name":"in.csv","type":"text/csv"}}}'`

## constraints
- エラー時に `show_multi_dialog()` 再実行や `reload_area()` をしない。
- 公開画面で画像/ファイル表示は `fields_view_direct` を優先する。
- `db()->insert()` / `update()` に配列リテラルを直接渡さず、変数化してから渡す（参照渡し対策）。
- CLI `app_call` の `files.path` 検証では `is_uploaded_file()` が `false` になるため、CLI時のみ `is_file()` を許可して検証する。
- 入力部品や `select` に固定 `width` は原則付けない。ユーザーが明示指定した場合のみ追加する。`style="width:220px;"` のような推測ベースの幅指定は入れない。
