<p>{t key="login.confirm_help" lang=$dialog_lang}</p>

<form id="new_account_confirm_form" onsubmit="return false;">
	<input type="hidden" name="class" value="login">
	<input type="hidden" name="function" value="make_new_account">

	<table class="setting_detail_table" style="margin-top:12px;">
			{foreach from=$confirm_items item=item}
				<tr>
					<th style="width:220px;">{t key=$item.label_key lang=$dialog_lang}</th>
					<td>{if $item.value != ""}{$item.value|escape}{else}{t key="common.not_set" lang=$dialog_lang}{/if}</td>
			</tr>
		{/foreach}
	</table>

	<div style="display:flex;justify-content:space-between;gap:12px;margin-top:18px;">
		<button type="button" class="ajax-link" data-class="login" data-function="make_new_account_confirm_back">{t key="common.back" lang=$dialog_lang}</button>
		<button class="ajax-link" data-form="new_account_confirm_form">{t key="login.make_new_account_button" lang=$dialog_lang}</button>
	</div>
</form>
