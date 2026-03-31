<form id="wizard_original_form_table_form">
	<p style="font-size:13px;color:#374151;margin:0 0 8px 0;">Original Form を追加する対象を選択してください。</p>
	<p style="font-weight:bold;margin:0 0 4px 0;">ボタン配置場所のテーブル *</p>
	{html_options name="db_id" options=$table_id_options selected=$row.db_id style="width:100%;"}
	<p class="error_message error_db_id"></p>

	<div style="margin-top:12px;overflow:auto;">
		<button type="button" class="ajax-link" invoke-function="back_to_db_additionals_select" style="float:left;">前へ</button>
		<button type="button" class="ajax-link" invoke-function="submit_original_form_table_next" data-form="wizard_original_form_table_form" style="float:right;">次へ</button>
	</div>
</form>
