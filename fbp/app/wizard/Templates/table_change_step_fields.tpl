<form id="wizard_table_change_fields_form">
	<p style="font-size:13px;color:#374151;margin:0 0 8px 0;">追加したい項目を入力してください（内部フィールド名ではなく、人が見る項目名ベース）。</p>
	<p style="margin:0 0 6px 0;font-size:12px;color:#6b7280;">例: 契約開始日（date） / 備考（textarea / 任意）</p>
	<p style="font-weight:bold;margin:0 0 4px 0;">追加項目 *</p>
	<textarea name="fields_text" rows="8" style="width:100%;">{$row.fields_text|escape}</textarea>
	<p class="error_message error_fields_text"></p>

	<div style="margin-top:12px;overflow:auto;">
		<button type="button" class="ajax-link" invoke-function="back_to_table_change_table" style="float:left;">前へ</button>
		<button type="button" class="ajax-link" invoke-function="submit_table_change_fields_next" data-form="wizard_table_change_fields_form" style="float:right;">次へ</button>
	</div>
</form>
