<?php

namespace openai;

/**
 * Recorder
 *
 * 会話のメッセージ履歴の永続化を担当するインターフェイス。
 * 実装例:
 *  - SessionRecorder: $_SESSION を使う
 *  - FileRecorder:    ローカルファイルを使う
 */
interface Recorder
{
    /**
     * 現在の全メッセージ履歴を取得する。
     * 戻り値は [ ['role' => 'user', 'content' => '...'], ... ] の配列。
     *
     * 実装側は、まだ何も保存されていない場合は空配列 [] を返すこと。
     *
     * @return array
     */
    public function read(): array;

    /**
     * メッセージ履歴を丸ごと保存/上書きする。
     * 引数は read() が返すのと同じ形にすること。
     *
     * @param array $messages
     * @return void
     */
    public function write(array $messages): void;

    /**
     * 1件メッセージを追記する。
     * role は "system" / "user" / "assistant" / "tool" など
     * content は自由（文字列 or 構造体）だが、呼び出し側と整合する形にする。
     *
     * @param string $role
     * @param mixed  $content
     * @return void
     */
    public function append(string $role, $content): void;
    
}
