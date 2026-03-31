<form id="wizard_line_bot_edit_rule_form">
	<p style="font-size:13px;color:#374151;margin:0 0 8px 0;">変更する Line Bot ルールを選択してください。友達追加時とキーワード入力時のみ対象です。</p>
	<p style="font-weight:bold;margin:0 0 4px 0;">変更対象ルール *</p>
	{html_options name="rule_id" options=$line_bot_edit_rule_options selected=$row.rule_id style="width:100%;"}
	<p class="error_message error_rule_id"></p>

	<div style="margin-top:12px;overflow:auto;">
		<button type="button" class="ajax-link" invoke-function="back_to_line_bot_select" style="float:left;">前へ</button>
		<button type="button" class="ajax-link" invoke-function="submit_line_bot_edit_rule_next" data-form="wizard_line_bot_edit_rule_form" style="float:right;">次へ</button>
	</div>
</form>
