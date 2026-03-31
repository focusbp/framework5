<?php

declare(strict_types=1);

/**
 * トークン使用量を会話内で合算管理するユーティリティ（PHP 7.3対応）
 * - OpenAI Responses/ChatCompletions 双方の usage 形式に対応
 * - 各API呼び出し後に addFromResponse() を都度呼ぶ
 * - getTotals() で合算値を取得
 *
 * 取り込み例：
 *   require_once __DIR__ . '/token_usage_tracker.php';
 *   $tracker = new token_usage_tracker();
 *   $res1 = $openai->responsesCreate($payload);
 *   $tracker->addFromResponse($res1);
 *   // ... ツール実行 → submit_tool_outputs → 続行 ...
 *   $res2 = $openai->responsesSubmitToolOutputs($rid, $toolOutputs);
 *   $tracker->addFromResponse($res2);
 *   $totals = $tracker->getTotals(); // ['input_tokens'=>..., 'output_tokens'=>..., 'total_tokens'=>...]
 */
class token_usage_tracker {

	/** @var int */
	private $totalInput = 0;

	/** @var int */
	private $totalOutput = 0;

	/** @var int */
	private $total = 0;

	/**
	 * OpenAIレスポンス配列から usage を検出して加算
	 */
	public function addFromResponse(array $response): void {
		// Responses API: $response['usage'] もしくは $response['response']['usage']
		$usage = [];
		if (isset($response['usage']) && is_array($response['usage'])) {
			$usage = $response['usage'];
		} elseif (isset($response['response']['usage']) && is_array($response['response']['usage'])) {
			$usage = $response['response']['usage'];
		}

		// Chat Completions など他形式にも緩やかに対応
		if (!empty($usage)) {
			$this->add($usage);
		}
	}

	/**
	 * usage配列を加算（input/prompt、output/completion の両方に対応）
	 */
	public function add(array $usage): void {
		$in = 0;
		$out = 0;
		$tot = 0;

		// Responses API
		if (isset($usage['input_tokens'])) {
			$in = (int) $usage['input_tokens'];
		}
		if (isset($usage['output_tokens'])) {
			$out = (int) $usage['output_tokens'];
		}
		if (isset($usage['total_tokens'])) {
			$tot = (int) $usage['total_tokens'];
		}

		// Chat Completions 互換
		if ($in === 0 && isset($usage['prompt_tokens'])) {
			$in = (int) $usage['prompt_tokens'];
		}
		if ($out === 0 && isset($usage['completion_tokens'])) {
			$out = (int) $usage['completion_tokens'];
		}
		if ($tot === 0) {
			$tot = $in + $out;
		}

		$this->totalInput += $in;
		$this->totalOutput += $out;
		$this->total += $tot;
	}

	/**
	 * 合算結果を返す
	 * @return array{input_tokens:int, output_tokens:int, total_tokens:int}
	 */
	public function getTotals(): array {
		return [
		    'input_tokens' => $this->totalInput,
		    'output_tokens' => $this->totalOutput,
		    'total_tokens' => $this->total,
		];
	}

	/**
	 * リセット（1ユーザーターンの開始時などに）
	 */
	public function reset(): void {
		$this->totalInput = 0;
		$this->totalOutput = 0;
		$this->total = 0;
	}
}
