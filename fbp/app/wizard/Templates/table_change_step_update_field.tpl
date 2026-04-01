<form id="wizard_table_change_update_field_form">
	<p style="font-size:13px;color:#374151;margin:0 0 8px 0;">{t key="wizard.table_change.update_field.description"}</p>
	<p style="font-weight:bold;margin:0 0 4px 0;">{t key="wizard.table_change.update_field.label"}</p>
	<div style="max-height:220px;overflow:auto;border:1px solid #d5dbe5;padding:8px;background:#fff;">
		{foreach $update_field_rows as $one}
			<label style="display:block;margin:0 0 6px 0;">
				<input type="checkbox" name="update_field_ids[]" value="{$one.id|escape}" {if $one.checked}checked{/if}>
				{$one.label|escape}
			</label>
		{/foreach}
	</div>
	<p class="error_message error_update_field_ids"></p>

	<p style="font-weight:bold;margin:8px 0 4px 0;">{t key="wizard.table_change.update_field.change_text"}</p>
	<textarea name="update_field_change_text" rows="8" style="width:100%;">{$row.update_field_change_text|escape}</textarea>
	<p style="margin:4px 0 0 0;font-size:12px;color:#6b7280;">{t key="wizard.table_change.update_field.example"}</p>
	<p class="error_message error_update_field_change_text"></p>

	<div style="margin-top:12px;overflow:auto;">
		<button type="button" class="ajax-link" invoke-function="back_to_table_change_table" style="float:left;">{t key="common.back"}</button>
		<button type="button" class="ajax-link" invoke-function="submit_table_change_update_field_next" data-form="wizard_table_change_update_field_form" style="float:right;">{t key="common.next"}</button>
	</div>
</form>
