<form id="wizard_line_bot_select_form">
	<p style="font-size:13px;color:#374151;margin:0 0 8px 0;">Line Botで追加したい内容を選択してください。</p>
	<div style="line-height:1.9;">
		<label style="display:block;"><input type="radio" name="line_action" value="member_link" {if $row.line_action == 'member_link'}checked{/if}> LINE用会員データベース作製</label>
		<label style="display:block;"><input type="radio" name="line_action" value="add" {if $row.line_action == 'add'}checked{/if}> Line Bot処理追加</label>
		<label style="display:block;"><input type="radio" name="line_action" value="edit" {if $row.line_action == 'edit'}checked{/if}> Line Bot処理変更</label>
		<label style="display:block;"><input type="radio" name="line_action" value="delete" {if $row.line_action == 'delete'}checked{/if}> Line Bot処理削除</label>
	</div>
	<p class="error_message error_line_action"></p>

	<div style="margin-top:12px;overflow:auto;">
		<button type="button" class="ajax-link" invoke-function="run" style="float:left;">前へ</button>
		<button type="button" class="ajax-link" invoke-function="submit_line_bot_action_next" data-form="wizard_line_bot_select_form" style="float:right;">次へ</button>
	</div>
</form>
