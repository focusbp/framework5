<form id="password_reset_form">
	<div>
		<p class="lang">New Password</p>
		<input type="password" name="password" value="">
		<p class="error_message error_password"></p>
	</div>
	<div>
		<p class="lang">Confirm Password</p>
		<input type="password" name="password_confirm" value="">
		<p class="error_message error_password_confirm"></p>
	</div>
</form>

<button class="ajax-link lang" data-class="password_reset" data-function="reset_exe" data-form="password_reset_form">Reset Password</button>
