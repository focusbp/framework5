<form id="user_password_reset_form">
	<input type="hidden" name="id" value="{$data.id}">

	<p class="lang">Login ID</p>
	<p>{$data.login_id}</p>

	<p class="lang">Email</p>
	<p>{$data.email}</p>

	<p class="lang">A password setup link will be sent to this user.</p>

	<button class="ajax-link lang" data-class="user" data-function="password_reset_exe" data-form="user_password_reset_form">Submit</button>
</form>
