<form id="wizard_line_bot_event_form">
	<p style="font-size:13px;color:#374151;margin:0 0 8px 0;">対象イベントを選択してください。</p>
	<p style="font-weight:bold;margin:0 0 4px 0;">イベント *</p>
	{html_options name="event_type" options=$line_bot_event_options selected=$row.event_type style="width:100%;"}
	<p class="error_message error_event_type"></p>

	<div style="margin-top:12px;overflow:auto;">
		<button type="button" class="ajax-link" invoke-function="back_to_line_bot_select" style="float:left;">前へ</button>
		<button type="button" class="ajax-link" invoke-function="submit_line_bot_event_next" data-form="wizard_line_bot_event_form" style="float:right;">次へ</button>
	</div>
</form>
