<form id="wizard_line_message_request_form">
	<p style="font-size:13px;color:#374151;margin:0 0 8px 0;">制作したい内容を入力してください。次へで Codex Terminal にプロンプトを投入します。</p>
	<table style="width:100%;border-collapse:collapse;font-size:13px;margin-bottom:8px;">
		<tr>
			<th style="width:180px;text-align:left;border:1px solid #d5dbe5;background:#f4f7fb;padding:8px;">ボタン配置場所のテーブル</th>
			<td style="border:1px solid #d5dbe5;padding:8px;">{$row.tb_name|escape}</td>
		</tr>
		<tr>
			<th style="text-align:left;border:1px solid #d5dbe5;background:#f4f7fb;padding:8px;">配置場所</th>
			<td style="border:1px solid #d5dbe5;padding:8px;">{$place_options[$row.place]|escape}</td>
		</tr>
		<tr>
			<th style="text-align:left;border:1px solid #d5dbe5;background:#f4f7fb;padding:8px;">送信先会員DB</th>
			<td style="border:1px solid #d5dbe5;padding:8px;">line_member (userid / line_name / name 固定)</td>
		</tr>
	</table>
	<p style="font-weight:bold;margin:0 0 4px 0;">ボタン名 *</p>
	<input type="text" name="button_title" value="{$row.button_title|escape}" style="width:100%;">
	<p class="error_message error_button_title"></p>
	<p style="font-weight:bold;margin:0 0 4px 0;">制作内容 *</p>
	<textarea name="request_text" rows="8" style="width:100%;">{$row.request_text|escape}</textarea>
	<p class="error_message error_request_text"></p>

	<div style="margin-top:12px;overflow:auto;">
		<button type="button" class="ajax-link" invoke-function="back_to_line_message_place" style="float:left;">前へ</button>
		<button type="button" class="ajax-link" invoke-function="submit_line_message_request_next" data-form="wizard_line_message_request_form" style="float:right;">次へ</button>
	</div>
</form>
