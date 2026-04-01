<form id="wizard_db_additionals_edit_target_form">
	<p style="font-size:13px;color:#374151;margin:0 0 8px 0;">{t key="wizard.db_additionals.edit_target.description"}</p>
	<p style="font-weight:bold;margin:0 0 4px 0;">{t key="wizard.db_additionals.edit_target.label"}</p>
	{html_options name="additional_id" options=$db_additionals_target_options selected=$row.additional_id style="width:100%;"}
	<p class="error_message error_additional_id"></p>

	<div style="margin-top:12px;overflow:auto;">
		<button type="button" class="ajax-link" invoke-function="back_to_db_additionals_manage_select" style="float:left;">{t key="common.back"}</button>
		<button type="button" class="ajax-link" invoke-function="submit_db_additionals_edit_target_next" data-form="wizard_db_additionals_edit_target_form" style="float:right;">{t key="common.next"}</button>
	</div>
</form>