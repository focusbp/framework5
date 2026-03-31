# app-framework5

`app-framework5` は **AIコーディング（エージェント開発）を前提** としたフレームワークです。  
人手作業よりも、エージェントが安全に実装・検証・運用できることを重視しています。

## 最初に必ず読む

開発を始める前に、必ず以下を読んでください。

- `docs/AGENTS.md`

このファイルには、実装時の分類方針、UI/Ajaxルール、完了条件、Skillの使い分けが定義されています。  
**AIエージェントに作業を依頼する場合も、最初に `docs/AGENTS.md` を読み込ませることが必須** です。

## このフレームワークの特徴

- AIエージェントでの実装・保守を想定した構成
- 機能別Skill（`screen_fields` / `db_additionals` / `dashboard` / `cron` / `webhook` / `embed_app` / `public_pages` など）で作業を標準化
- CLIベースで検証しやすい運用
- 画面実装とデータ処理のルールを明文化し、品質ぶれを抑制

## 推奨ワークフロー（AI利用時）

1. 要件を分類する（`screen_fields` / `post_action_class` / `db_additionals` / `dashboard` / `cron` / `webhook` / `embed_app` / `public_pages`）。
2. `docs/AGENTS.md` の指示に従って該当Skillを選ぶ。
3. 実装する。
4. 最低限の完了条件を満たすまで検証する。

## 最低限の完了条件

- `app_call` が成功する
- 更新系は `data_get` または `data_list` で反映確認する
- 公開導線は `app_check` で主要シナリオを確認する

## 実装ルール（要点）

- `_buttons_prompt_form.tpl` の allowlist に従う
- URLは文字列連結せず `$ctl->get_APP_URL()` で生成する
- バリデーションエラーは `res_error_message()` を返して即 `return` する
- エラー時に `show_multi_dialog()` 再実行や `reload_area()` で再描画しない
- フォーム/表示は helper 優先（`fields_form_direct` / `fields_form_original` / `fields_view_direct`）

## 注意

- 環境固有の手順（ローカルパス、配布・同期手順）は共通ルールに混ぜず、該当Skillへ分離してください。
- 仕様や運用ルールを更新した場合は、`docs/AGENTS.md` と関連Skillを同時に更新してください。

## ライセンス

- フレームワーク本体のライセンスは `fbp/LICENSE` を参照してください。
- 同梱OSSのライセンス一覧は `THIRD_PARTY_LICENSES.md` を参照してください。
- 各OSSの正確な条件は、それぞれの同梱ライセンスファイルに従ってください。
