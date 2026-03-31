<form id="wizard_note_select_form" onsubmit="return false;">
	<p style="font-size:13px;color:#374151;margin:0 0 8px 0;">まず、ノートに対して何を行うか選択してください。</p>
	<div style="line-height:1.9;">
		<label style="display:block;"><input type="radio" name="note_action" value="add" {if $row.note_action == 'add'}checked{/if}> ノートの追加</label>
		<label style="display:block;"><input type="radio" name="note_action" value="update" {if $row.note_action == 'update'}checked{/if}> ノートの設定変更</label>
		<label style="display:block;"><input type="radio" name="note_action" value="delete" {if $row.note_action == 'delete'}checked{/if}> ノートの削除</label>
		<label style="display:block;"><input type="radio" name="note_action" value="child_add" {if $row.note_action == 'child_add'}checked{/if}> 子ノート追加</label>
		<label style="display:block;"><input type="radio" name="note_action" value="parent_child" {if $row.note_action == 'parent_child'}checked{/if}> 親子ノート設定</label>
	</div>
	<p class="error_message error_note_action"></p>

	<div style="margin-top:12px;overflow:auto;">
		<button type="button" class="ajax-link" invoke-function="run" style="float:left;">前へ</button>
		<button type="button" class="ajax-link" invoke-function="submit_note_action_next" data-form="wizard_note_select_form" style="float:right;">次へ</button>
	</div>
</form>
