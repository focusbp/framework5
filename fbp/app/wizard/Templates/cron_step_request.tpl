<form id="wizard_cron_request_form">
	<p style="font-size:13px;color:#374151;margin:0 0 8px 0;">定期実行したい処理内容を入力してください。次へで LLM が定期処理名と cron 登録値を自動判別し、そのまま Codex Terminal にプロンプトを投入します。</p>
	<table style="width:100%;border-collapse:collapse;font-size:13px;margin-bottom:8px;">
		<tr>
			<th style="width:180px;text-align:left;border:1px solid #d5dbe5;background:#f4f7fb;padding:8px;">実行のタイミング</th>
			<td style="border:1px solid #d5dbe5;padding:8px;">{$row.timing_text|escape}</td>
		</tr>
	</table>
	<p style="font-weight:bold;margin:0 0 4px 0;">処理内容 *</p>
	<textarea name="request_text" rows="8" style="width:100%;">{$row.request_text|escape}</textarea>
	<p style="font-size:12px;color:#6b7280;margin:4px 0 0 0;">例: 売上集計を送る / 未入金者へ通知 / 在庫同期を行う</p>
	<p class="error_message error_request_text"></p>

	<div style="margin-top:12px;overflow:auto;">
		<button type="button" class="ajax-link" invoke-function="back_to_cron_timing" style="float:left;">前へ</button>
		<button type="button" class="ajax-link" invoke-function="submit_cron_request_next" data-form="wizard_cron_request_form" style="float:right;">次へ</button>
	</div>
</form>
