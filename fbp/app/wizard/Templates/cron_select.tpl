<form id="wizard_cron_select_form">
	<p style="font-size:13px;color:#374151;margin:0 0 8px 0;">Cronで実行したい内容を選択してください。</p>
	<div style="line-height:1.9;">
		<label style="display:block;"><input type="radio" name="cron_action" value="add" {if $row.cron_action == 'add'}checked{/if}> 定期処理追加</label>
		<label style="display:block;"><input type="radio" name="cron_action" value="edit" {if $row.cron_action == 'edit'}checked{/if}> 定期処理変更</label>
		<label style="display:block;"><input type="radio" name="cron_action" value="delete" {if $row.cron_action == 'delete'}checked{/if}> 定期処理削除</label>
	</div>
	<p class="error_message error_cron_action"></p>

	<div style="margin-top:12px;overflow:auto;">
		<button type="button" class="ajax-link" invoke-function="run" style="float:left;">前へ</button>
		<button type="button" class="ajax-link" invoke-function="submit_cron_action_next" data-form="wizard_cron_select_form" style="float:right;">次へ</button>
	</div>
</form>
