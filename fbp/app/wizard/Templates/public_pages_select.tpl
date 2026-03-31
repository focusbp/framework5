<form id="wizard_public_pages_select_form">
	<p style="font-size:13px;color:#374151;margin:0 0 8px 0;">public_pages で追加したい内容を選択してください。</p>
	<div style="line-height:1.9;">
		<label style="display:block;"><input type="radio" name="page_action" value="asset_add" {if $row.page_action == 'asset_add'}checked{/if}> 画像の登録</label>
		<label style="display:block;"><input type="radio" name="page_action" value="common_design" {if $row.page_action == 'common_design'}checked{/if}> 共通デザイン（ヘッダ・フッタ）作製</label>
		<label style="display:block;"><input type="radio" name="page_action" value="add" {if $row.page_action == 'add'}checked{/if}> 新規ページ追加</label>
		<label style="display:block;"><input type="radio" name="page_action" value="edit" {if $row.page_action == 'edit'}checked{/if}> 既存ページ変更</label>
		<label style="display:block;"><input type="radio" name="page_action" value="delete" {if $row.page_action == 'delete'}checked{/if}> 既存ページ削除</label>
		<label style="display:block;"><input type="radio" name="page_action" value="menu_manage" {if $row.page_action == 'menu_manage'}checked{/if}> メニューの管理</label>
	</div>
	<p class="error_message error_page_action"></p>

	<div style="margin-top:12px;overflow:auto;">
		<button type="button" class="ajax-link" invoke-function="run" style="float:left;">前へ</button>
		<button type="button" class="ajax-link" invoke-function="submit_public_pages_action_next" data-form="wizard_public_pages_select_form" style="float:right;">次へ</button>
	</div>
</form>
