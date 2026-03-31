<?php

namespace openai;

/**
 * Function Calling 用インターフェイス
 */
interface FunctionTool
{
    /** ツール名（英数字と_推奨） */
    public function name(): string;

    /** 説明文 */
    public function description(): string;

    /** JSON Schema (Draft-07想定) の parameters 定義 */
    public function parameters(): array;

    /**
     * 実処理本体。モデルから渡された引数を受け取り結果を返す。
     * 返り値は string または array（JSON化されて tool_outputs に入ります）
     * @param array $arguments
     * @return mixed string|array
     */
    public function execute(\Controller $ctl,array $arguments);
    

}
