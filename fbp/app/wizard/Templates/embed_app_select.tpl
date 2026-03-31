<form id="wizard_embed_app_select_form">
	<p style="font-size:13px;color:#374151;margin:0 0 8px 0;">Embed App で実行したい内容を選択してください。</p>
	<div style="line-height:1.9;">
		<label style="display:block;"><input type="radio" name="embed_action" value="add" {if $row.embed_action == 'add'}checked{/if}> 新規制作</label>
		<label style="display:block;"><input type="radio" name="embed_action" value="edit" {if $row.embed_action == 'edit'}checked{/if}> 既存変更</label>
		<label style="display:block;"><input type="radio" name="embed_action" value="delete" {if $row.embed_action == 'delete'}checked{/if}> 削除</label>
	</div>
	<p class="error_message error_embed_action"></p>

	<div style="margin-top:12px;overflow:auto;">
		<button type="button" class="ajax-link" invoke-function="run" style="float:left;">前へ</button>
		<button type="button" class="ajax-link" invoke-function="submit_embed_app_action_next" data-form="wizard_embed_app_select_form" style="float:right;">次へ</button>
	</div>
</form>
