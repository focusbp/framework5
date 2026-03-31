
<p>For the management account does not exist, please create a new account.</p>

<form id="new_form" style="height:300px;">
	<input type="hidden" name="class" value="login">
	<input type="hidden" name="function" value="make_new_account">
	<div class="form-wrap form-wrap-validation has-error">
		<p class="lang">Login ID</p>
		<input type="text" name="login_id" value="{$login_id}" autocomplete="username">
		<p class="error_message error_login_id"></p>
		<p class="lang" style="margin-top:10px;">Password</p>
		<input type="password" name="password" value="{$password}" autocomplete="current-password">
		<p class="error_message error_password"></p>


	</div>	

	<button class="ajax-link lang" data-form="new_form" style="float:right;margin-top:18px;">Make New Account</button>

</form>

