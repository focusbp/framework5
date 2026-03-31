<form id="wizard_step_parent_form" onsubmit="return false;">
	<p style="font-size:13px;color:#374151;margin:0 0 8px 0;">子ノートを追加する親ノートを選択してください。その後の流れは通常のノート追加と同じです。</p>
	<p style="font-weight:bold;margin:0 0 4px 0;">親ノート *</p>
	{html_options name="parent_tb_name" options=$table_options selected=$row.parent_tb_name}
	<p class="error_message error_parent_tb_name"></p>
	<div style="margin-top:12px;overflow:auto;">
		<button type="button" class="ajax-link" invoke-function="back_to_note_select" style="float:left;">前へ</button>
		<button type="button" class="ajax-link" invoke-function="submit_child_note_parent_next" data-form="wizard_step_parent_form" style="float:right;">次へ</button>
	</div>
</form>
