---
name: fbp-standard-screen
description: Build and adjust standard FBP screens using screen_fields and helper-first patterns.
---

# fbp-standard-screen

## trigger conditions
- 標準画面（list/add/edit/delete/list_on_side）を構築・修正する
- helper利用方針（fields_form_direct等）の判断が必要

## workflow
1. まず `screen_fields` で実現可能か判定。
2. 入力は `fields_form_direct`（非DBは `fields_form_original`）を優先。
3. 表示は `fields_view_direct` を優先。
4. 反映範囲を `list/add/edit/delete` で確認し、親ありなら `list_on_side` も確認。

## constraints
- 手書き `<input>/<select>/<textarea>` は例外時のみ。
- 手書きの表示値展開（`{$row.xxx}` 直書き等）は例外時のみとし、原則 `fields_view_direct` を使う。
- 例外時は理由を明示可能な状態にする。
- `constant_array` にある選択肢ラベル（status/type等）はハードコードしない。`$ctl->get_constant_array()` または `fields_view_direct` でフレームワーク定義を参照する。
- URL生成は `$ctl->get_APP_URL()` を必須とし、`app.php?class=...` や `$_SERVER` 連結での直書きURLを増やさない。
- `screen_fields` 登録前に、日付項目のDB型が `date` になっていることを確認する。
