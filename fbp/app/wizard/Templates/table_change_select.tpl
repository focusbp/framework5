<form id="wizard_table_change_select_form">
	<p style="font-size:13px;color:#374151;margin:0 0 8px 0;">まず、どの変更を行うか選択してください。</p>
	<div style="line-height:1.9;">
		<label style="display:block;"><input type="radio" name="change_action" value="add_field" {if $row.change_action == 'add_field'}checked{/if}> テーブルへの項目追加</label>
		<label style="display:block;"><input type="radio" name="change_action" value="delete_field" {if $row.change_action == 'delete_field'}checked{/if}> テーブルへの項目削除</label>
		<label style="display:block;"><input type="radio" name="change_action" value="update_field" {if $row.change_action == 'update_field'}checked{/if}> テーブルへの項目変更</label>
		<label style="display:block;"><input type="radio" name="change_action" value="add_screen_field" {if $row.change_action == 'add_screen_field'}checked{/if}> 標準画面への項目追加・削除</label>
	</div>
	<p class="error_message error_change_action"></p>

	<div style="margin-top:12px;overflow:auto;">
		<button type="button" class="ajax-link" invoke-function="run" style="float:left;">前へ</button>
		<button type="button" class="ajax-link" invoke-function="submit_table_change_action_next" data-form="wizard_table_change_select_form" style="float:right;">次へ</button>
	</div>
</form>
