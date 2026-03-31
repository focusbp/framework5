<form id="wizard_csv_upload_request_form">
	<p style="font-size:13px;color:#374151;margin:0 0 8px 0;">CSV Uploadで実現したい内容を入力してください。次へで Codex Terminal にプロンプトを投入します。</p>
	<table style="width:100%;border-collapse:collapse;font-size:13px;margin-bottom:8px;">
		<tr>
			<th style="width:180px;text-align:left;border:1px solid #d5dbe5;background:#f4f7fb;padding:8px;">ボタン配置場所のテーブル</th>
			<td style="border:1px solid #d5dbe5;padding:8px;">{$row.tb_name|escape}</td>
		</tr>
		<tr>
			<th style="text-align:left;border:1px solid #d5dbe5;background:#f4f7fb;padding:8px;">配置場所</th>
			<td style="border:1px solid #d5dbe5;padding:8px;">{$place_options[$row.place]|escape}</td>
		</tr>
	</table>
	<p style="font-weight:bold;margin:0 0 4px 0;">使用フィールド</p>
	<div style="max-height:220px;overflow:auto;border:1px solid #d5dbe5;margin-top:0px;margin-bottom:8px;">
		<table style="width:100%;border-collapse:collapse;font-size:12px;">
			<thead>
				<tr>
					<th style="width:180px;border:1px solid #d5dbe5;background:#f4f7fb;padding:6px;text-align:left;">field_name</th>
					<th style="width:180px;border:1px solid #d5dbe5;background:#f4f7fb;padding:6px;text-align:left;">title</th>
					<th style="border:1px solid #d5dbe5;background:#f4f7fb;padding:6px;text-align:left;">options</th>
				</tr>
			</thead>
			<tbody>
				{if $csv_upload_selected_fields|@count > 0}
					{foreach $csv_upload_selected_fields as $one}
						<tr>
							<td style="border:1px solid #d5dbe5;padding:6px;">{$one.field_name|escape}</td>
							<td style="border:1px solid #d5dbe5;padding:6px;">{$one.title|escape}</td>
							<td style="border:1px solid #d5dbe5;padding:6px;">{$one.options_text|escape}</td>
						</tr>
					{/foreach}
				{else}
					<tr>
						<td colspan="3" style="border:1px solid #d5dbe5;padding:6px;color:#6b7280;">選択されたフィールドはありません。</td>
					</tr>
				{/if}
			</tbody>
		</table>
	</div>
	<p style="font-weight:bold;margin:0 0 4px 0;">ボタン名 *</p>
	<input type="text" name="button_title" value="{$row.button_title|escape}" style="width:100%;">
	<p class="error_message error_button_title"></p>
	<p style="font-weight:bold;margin:0 0 4px 0;">CSV Upload 制作内容 *</p>
	<textarea name="request_text" rows="8" style="width:100%;">{$row.request_text|escape}</textarea>
	<p class="error_message error_request_text"></p>

	<div style="margin-top:12px;overflow:auto;">
		<button type="button" class="ajax-link" invoke-function="back_to_csv_upload_fields" style="float:left;">前へ</button>
		<button type="button" class="ajax-link" invoke-function="submit_csv_upload_request_next" data-form="wizard_csv_upload_request_form" style="float:right;">次へ</button>
	</div>
</form>
