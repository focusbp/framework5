<form id="wizard_cron_timing_form">
	<p style="font-size:13px;color:#374151;margin:0 0 8px 0;">実行のタイミングを自然文で入力してください。</p>
	<p style="font-weight:bold;margin:0 0 4px 0;">実行のタイミング *</p>
	<textarea name="timing_text" rows="6" style="width:100%;">{$row.timing_text|escape}</textarea>
	<p style="font-size:12px;color:#6b7280;margin:4px 0 0 0;">例: 毎日午前9時 / 毎週月曜の朝8時 / 10分おき / 毎月1日の6時</p>
	<p class="error_message error_timing_text"></p>

	<div style="margin-top:12px;overflow:auto;">
		{if $row.cron_action == 'edit'}
			<button type="button" class="ajax-link" invoke-function="back_to_cron_target" style="float:left;">前へ</button>
		{else}
			<button type="button" class="ajax-link" invoke-function="back_to_cron_select" style="float:left;">前へ</button>
		{/if}
		<button type="button" class="ajax-link" invoke-function="submit_cron_timing_next" data-form="wizard_cron_timing_form" style="float:right;">次へ</button>
	</div>
</form>
