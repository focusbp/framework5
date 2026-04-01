<form id="wizard_db_additionals_delete_confirm_form">
	<p style="font-size:13px;color:#374151;margin:0 0 8px 0;">{t key="wizard.db_additionals.delete_confirm.description"}</p>
	<table style="width:100%;border-collapse:collapse;font-size:13px;margin-bottom:8px;">
		<tr>
			<th style="width:180px;text-align:left;border:1px solid #d5dbe5;background:#f4f7fb;padding:8px;">{t key="wizard.db_additionals.edit_request.note"}</th>
			<td style="border:1px solid #d5dbe5;padding:8px;">{$row.note_name|escape}</td>
		</tr>
		<tr>
			<th style="text-align:left;border:1px solid #d5dbe5;background:#f4f7fb;padding:8px;">{t key="wizard.db_additionals.edit_request.button_title"}</th>
			<td style="border:1px solid #d5dbe5;padding:8px;">{$row.button_title|escape}</td>
		</tr>
		<tr>
			<th style="text-align:left;border:1px solid #d5dbe5;background:#f4f7fb;padding:8px;">{t key="wizard.db_additionals.edit_request.class_name"}</th>
			<td style="border:1px solid #d5dbe5;padding:8px;">{$row.class_name|escape}</td>
		</tr>
		<tr>
			<th style="text-align:left;border:1px solid #d5dbe5;background:#f4f7fb;padding:8px;">{t key="wizard.db_additionals.edit_request.function_name"}</th>
			<td style="border:1px solid #d5dbe5;padding:8px;">{$row.function_name|escape}</td>
		</tr>
		<tr>
			<th style="text-align:left;border:1px solid #d5dbe5;background:#f4f7fb;padding:8px;">{t key="wizard.db_additionals.edit_request.place"}</th>
			<td style="border:1px solid #d5dbe5;padding:8px;">{$db_additionals_place_label|escape}</td>
		</tr>
	</table>
	<p style="margin:0;color:#b91c1c;font-size:13px;">{t key="wizard.db_additionals.delete_confirm.warning"}</p>

	<div style="margin-top:12px;overflow:auto;">
		<button type="button" class="ajax-link" invoke-function="back_to_db_additionals_delete_target" style="float:left;">{t key="common.back"}</button>
		<button type="button" class="ajax-link" invoke-function="submit_db_additionals_delete_exe" data-form="wizard_db_additionals_delete_confirm_form" style="float:right;">{t key="common.delete"}</button>
	</div>
</form>