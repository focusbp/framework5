<form id="wizard_dashboard_select_form">
	<p style="font-size:13px;color:#374151;margin:0 0 8px 0;">Dashboard で実行したい内容を選択してください。</p>
	<div style="line-height:1.9;">
		<label style="display:block;"><input type="radio" name="dashboard_action" value="add" {if $row.dashboard_action == 'add'}checked{/if}> Dashboard 追加</label>
		<label style="display:block;"><input type="radio" name="dashboard_action" value="edit" {if $row.dashboard_action == 'edit'}checked{/if}> Dashboard 変更</label>
		<label style="display:block;"><input type="radio" name="dashboard_action" value="delete" {if $row.dashboard_action == 'delete'}checked{/if}> Dashboard 削除</label>
	</div>
	<p class="error_message error_dashboard_action"></p>

	<div style="margin-top:12px;overflow:auto;">
		<button type="button" class="ajax-link" invoke-function="run" style="float:left;">前へ</button>
		<button type="button" class="ajax-link" invoke-function="submit_dashboard_action_next" data-form="wizard_dashboard_select_form" style="float:right;">次へ</button>
	</div>
</form>
