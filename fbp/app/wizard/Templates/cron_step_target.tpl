<form id="wizard_cron_target_form">
	{if $cron_target_mode == 'delete'}
		<p style="font-size:13px;color:#374151;margin:0 0 8px 0;">削除する定期処理を選択してください。次へで削除を実行します。</p>
		<p style="font-weight:bold;margin:0 0 4px 0;">削除対象 *</p>
	{else}
		<p style="font-size:13px;color:#374151;margin:0 0 8px 0;">変更する定期処理を選択してください。</p>
		<p style="font-weight:bold;margin:0 0 4px 0;">変更対象 *</p>
	{/if}
	{html_options name="cron_id" options=$cron_id_options selected=$row.cron_id style="width:100%;"}
	<p class="error_message error_cron_id"></p>

	<div style="margin-top:12px;overflow:auto;">
		<button type="button" class="ajax-link" invoke-function="back_to_cron_select" style="float:left;">前へ</button>
		<button type="button" class="ajax-link" invoke-function="submit_cron_target_next" data-form="wizard_cron_target_form" style="float:right;">次へ</button>
	</div>
</form>
