
<p>{t key="login.new_account_help" lang=$dialog_lang}</p>

<form id="new_form" style="height:300px;">
	<input type="hidden" name="class" value="login">
	<input type="hidden" name="function" value="make_new_account_project_release_code">
	<div class="form-wrap form-wrap-validation has-error">
		<p>{t key="user.login_id" lang=$dialog_lang}</p>
		<input type="text" name="login_id" value="{$login_id}" autocomplete="username">
		<p class="error_message error_login_id"></p>
		<p style="margin-top:10px;">{t key="login.password" lang=$dialog_lang}</p>
		<input type="password" name="password" value="{$password}" autocomplete="current-password">
		<p class="error_message error_password"></p>


	</div>	

	<div style="display:flex;justify-content:space-between;gap:12px;margin-top:18px;">
		<button type="button" class="ajax-link" data-class="login" data-function="make_new_account_back">{t key="common.back" lang=$dialog_lang}</button>
		<button class="ajax-link" data-form="new_form">{t key="common.next" lang=$dialog_lang}</button>
	</div>

</form>
