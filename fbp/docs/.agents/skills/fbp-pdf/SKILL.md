---
name: fbp-pdf
description: Implement and test PDF generation flows in FBP, including modern tpl-less patterns and media inclusion.
---

# fbp-pdf

## trigger conditions
- PDF出力機能を追加・修正する
- 新方式PDF（tplなし）で実装する

## workflow
1. 出力要件とデータ取得元を確定。
2. PDFクラスを実装（必要なら画像処理含む）。
3. `db_additional` 起点の場合は、まず `show_multi_dialog()` で確認ダイアログを表示する。
4. ダイアログ内の「ダウンロード」ボタンは `download-link` を使い、PDF生成関数を直接呼ぶ。
5. PDF用 `download-link` には原則 `data-open_new_tab="true"` を付ける。
6. `app_call` のファイル出力指定で生成テスト。
7. 保存ファイルと内容を確認。

## constraints
- 文字化け・画像パス・ページ崩れを優先チェックする。
- PDFダウンロード導線に `ajax-link` は使わない（ダウンロードデータを扱えないため）。
- `download-link` の `data-class` は明示的に実クラス名を指定する（`{$class}` 依存を避ける）。
- PDFダウンロードの `download-link` は `data-open_new_tab="true"` を基本とする。例外時は理由を実装コメントかPR説明に残す。
- `addTable` の `columnsize` は合計 `100` にする（%指定として扱うため）。
