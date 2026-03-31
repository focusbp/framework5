# NetBeansProjects.md

## 概要
`NetBeansProjects` ディレクトリがある環境での開発ルールを定義する。

## 前提
- フレームワークのプロジェクト: `NetBeansProjects/app-framework5`
- フレームワークの実行場所: `web/app-framework5`
- この環境は本番ではなく開発環境。
- 文脈上 `fbp/` と指示がある場合は `NetBeansProjects/app-framework5` 側を指す。
- 文脈上 `classes/` と指示がある場合は、フレームワーク以外のプロジェクトを指すことが多い。

## 厳格ルール（必須）
- ソース編集は必ず `NetBeansProjects -> web` の一方向で行う。
- `web -> NetBeansProjects` の逆コピー・逆同期は行わない。
- `cli` は必ず `web` 側で実行する。
- URLは文字列連結で作らず、必ず `$ctl->get_APP_URL()` を使う。

## 既存プロジェクト改修時の注意
- 旧実装では `"/app.php?class=..."` や `$_SERVER` 連結でURLを生成している箇所が残っていることが多い。
- 改修時は同時に該当箇所を探索し、`$ctl->get_APP_URL(class, function, params)` へ置換する。
- URL生成ロジックを追加・変更したPRでは、直書きURLが残っていないか `rg "app\\.php\\?class=|REQUEST_URI|HTTP_ORIGIN"` で確認する。

## 同期方法
- `NetBeansProjects` で編集後、`web` への反映は次を使う。  
  `scripts/copy_to_web.sh <<project_name>>`

## フレームワーク以外のプロジェクト
- 原則として同じルール（編集は `NetBeansProjects`、実行は `web`）。
- フレームワーク反映は次を実行する。  
  `web/release_fw5.sh`
- これにより各プロジェクトへ最新フレームワークが配布される。
