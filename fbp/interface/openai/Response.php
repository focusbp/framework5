<?php

namespace openai;

interface Response
{

    /** 生配列のエイリアス */
    public function toArray(): array;

    /** response_id を取得（ツール往復の継続などに使用） */
    public function response_id(): ?string;

    /** 返答本文（テキスト）を結合して取得 */
    public function get_text(): string;

    /** 返答本文（message単位）を配列で取得 */
    public function get_text_blocks(): array;

    /**
     * ツール呼び出し（Function Calling）の正規化配列を取得
     * 返り値: [['id'=>?string,'name'=>?string,'arguments'=>array,'raw'=>array], ...]
     */
    public function get_tool_calls(): array;

    /** アシスタントの message（生）配列を取得 */
    public function get_assistant_messages_raw(): array;
    

}