<form id="wizard_note_delete_table_form" onsubmit="return false;">
	<p style="font-size:13px;color:#374151;margin:0 0 8px 0;">削除したいノートを選択してください。削除はノート定義と関連データをまとめて対象にします。</p>
	<p style="font-weight:bold;margin:0 0 4px 0;">削除対象ノート *</p>
	{html_options name="target_tb_name" options=$table_options selected=$row.target_tb_name}
	<p class="error_message error_target_tb_name"></p>

	<div style="margin-top:12px;overflow:auto;">
		<button type="button" class="ajax-link" invoke-function="back_to_note_select" style="float:left;">前へ</button>
		<button type="button" class="ajax-link" invoke-function="submit_note_delete_table_next" data-form="wizard_note_delete_table_form" style="float:right;">次へ</button>
	</div>
</form>
