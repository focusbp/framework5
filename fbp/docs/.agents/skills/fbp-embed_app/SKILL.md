---
name: fbp-embed_app
description: Create and maintain router-based embed_app implementations, tag generation, and CLI verification.
---

# fbp-embed_app

## trigger conditions
- embed_app（router方式）を新規作成・更新する
- 埋め込みタグや origin 条件の調整が必要

## workflow
1. `embed_app_list` で既存確認。
2. router方式で `embed_app` を作成/編集。
3. 埋め込みタグを生成し、origin付きで動作確認。
4. チェックリスト（URL・キー・origin）を満たすことを確認。

## constraints
- 既存 `db_widget` がある場合は移行影響を確認する。
