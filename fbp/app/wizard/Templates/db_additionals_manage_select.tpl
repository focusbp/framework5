<form id="wizard_db_additionals_manage_select_form">
	<p style="font-size:13px;color:#374151;margin:0 0 8px 0;">{t key="wizard.db_additionals.manage_select.description"}</p>
	<div style="line-height:1.9;">
		<label style="display:block;"><input type="radio" name="manage_action" value="edit" {if $row.manage_action == 'edit'}checked{/if}> {t key="wizard.db_additionals.manage_select.action_edit"}</label>
		<label style="display:block;"><input type="radio" name="manage_action" value="delete" {if $row.manage_action == 'delete'}checked{/if}> {t key="wizard.db_additionals.manage_select.action_delete"}</label>
		<label style="display:block;"><input type="radio" name="manage_action" value="sort" {if $row.manage_action == 'sort'}checked{/if}> {t key="wizard.db_additionals.manage_select.action_sort"}</label>
	</div>
	<p class="error_message error_manage_action"></p>

	<div style="margin-top:12px;overflow:auto;">
		<button type="button" class="ajax-link" invoke-function="run" style="float:left;">{t key="common.back"}</button>
		<button type="button" class="ajax-link" invoke-function="submit_db_additionals_manage_action_next" data-form="wizard_db_additionals_manage_select_form" style="float:right;">{t key="common.next"}</button>
	</div>
</form>