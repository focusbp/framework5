<form id="user_password_reset_form">
	<input type="hidden" name="id" value="{$data.id}">

	<p class="lang">Login ID</p>
	<p>{$data.login_id}</p>

	<p class="lang">New Password</p>
	<input type="password" name="password" value="">
	<p class="error_message error_password"></p>

	<p class="lang">Confirm Password</p>
	<input type="password" name="password_confirm" value="">
	<p class="error_message error_password_confirm"></p>

	<button class="ajax-link lang" data-class="user" data-function="password_reset_exe" data-form="user_password_reset_form">Submit</button>
</form>
