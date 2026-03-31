<form id="wizard_parent_child_note_child_form" onsubmit="return false;">
	<p style="font-size:13px;color:#374151;margin:0 0 8px 0;">設定を変更したい子ノートを選択してください。</p>
	<p style="font-weight:bold;margin:0 0 4px 0;">子ノート *</p>
	{html_options name="child_tb_name" options=$child_table_options selected=$row.child_tb_name}
	<p class="error_message error_child_tb_name"></p>
	<div style="margin-top:12px;overflow:auto;">
		<button type="button" class="ajax-link" invoke-function="back_to_note_select" style="float:left;">前へ</button>
		<button type="button" class="ajax-link" invoke-function="submit_parent_child_note_child_next" data-form="wizard_parent_child_note_child_form" style="float:right;">次へ</button>
	</div>
</form>
