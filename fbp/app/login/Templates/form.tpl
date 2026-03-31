
{if $flg_login_logo}
	<img src="app.php?class=login&function=logo">
{else}
	<img src="app.php?class=login&function=logo_default">
{/if}

{if $user}
	<div>
		<h5>Your account has been created for login. Please save the information below immediately.</h5>
		<p class="first_account">Login ID : {$user.login_id}</p>
		<p class="first_account">Password : {$user.password}</p>
	</div>
{/if}

<form id="login_form">
	<input type="hidden" name="class" value="login">
	<input type="hidden" name="function" value="check">
	<div class="form-wrap form-wrap-validation has-error">
		<p class="lang">Login ID</p>
		<input type="text" name="login_id" value="{$login_id}" autocomplete="username">
		<p class="lang" style="margin-top:10px;">Password</p>
		<input type="password" name="password" value="{$password}" autocomplete="current-password">
		<p id="err_password" class="error">{$err_password}</p>

		{html_options id="lang_selector" name="lang_selector" options=$arr_lang selected=$lang style="width:200px;height:45px;border-radius:5px;margin-top:12px;float:left;" class="lang"}
	</div>	

	<button class="ajax-link lang" data-form="login_form" style="float:right;margin-top:18px;">Login</button>

</form>

<script>
	$("#lang_selector").change(function () {
		var lang = $("#lang_selector").val();
		Cookies.set("lang", lang);
	});
</script>