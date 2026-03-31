---
name: fbp-api-auth
description: Implement HMAC-SHA256 API authentication for FBP API classes and provide reproducible client-side test flows.
---

# fbp-api-auth

## trigger conditions
- APIクラスの認証追加・修正を行う
- HMAC署名仕様のクライアント検証が必要

## workflow
1. APIクラス名を `*_api` で統一。
2. エントリで `verify_api_request()` を実行し不正時は終了。
3. canonical文字列と署名仕様を合わせる。
4. bash/Pythonクライアントで署名付きリクエスト検証。

## constraints
- `api_secret` をログやレスポンスに出さない。
- 時刻ズレ許容やnonce再利用防止の方針を明示する。
