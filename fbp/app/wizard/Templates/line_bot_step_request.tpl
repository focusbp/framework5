<form id="wizard_line_bot_request_form">
	<p style="font-size:13px;color:#374151;margin:0 0 8px 0;">Line Botで実現したい内容を入力してください。次へで Codex Terminal にプロンプトを投入します。</p>
	<table style="width:100%;border-collapse:collapse;font-size:13px;margin-bottom:8px;">
		<tr>
			<th style="width:180px;text-align:left;border:1px solid #d5dbe5;background:#f4f7fb;padding:8px;">イベント</th>
			<td style="border:1px solid #d5dbe5;padding:8px;">{$line_bot_event_options[$row.event_type]|escape}</td>
		</tr>
		<tr>
			<th style="text-align:left;border:1px solid #d5dbe5;background:#f4f7fb;padding:8px;">keyword</th>
			<td style="border:1px solid #d5dbe5;padding:8px;">{$line_bot_keyword_preview|escape}</td>
		</tr>
	</table>
	<p style="font-weight:bold;margin:0 0 4px 0;">制作内容 *</p>
	<textarea name="request_text" rows="8" style="width:100%;">{$row.request_text|escape}</textarea>
	<p class="error_message error_request_text"></p>

	<div style="margin-top:12px;overflow:auto;">
		{if $row.event_type == 'keyword'}
			<button type="button" class="ajax-link" invoke-function="back_to_line_bot_keyword" style="float:left;">前へ</button>
		{else}
			<button type="button" class="ajax-link" invoke-function="back_to_line_bot_event" style="float:left;">前へ</button>
		{/if}
		<button type="button" class="ajax-link" invoke-function="submit_line_bot_request_next" data-form="wizard_line_bot_request_form" style="float:right;">次へ</button>
	</div>
</form>
