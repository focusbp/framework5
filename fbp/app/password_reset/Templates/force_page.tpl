<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="user-scalable=1">
		{include file="{$base_template_dir}/publicsite_header.tpl"}
		<title>Password Reset : Focus Business Platform</title>
	</head>
	<body>
		<article class="class_style_{$class}">
			<div id="login_area">
				<h3 class="lang">Password Reset Required</h3>
				<p class="lang">Please reset your password before proceeding.</p>

				<form method="post" action="app.php">
					<input type="hidden" name="class" value="password_reset">
					<input type="hidden" name="function" value="force_reset_exe">

					<p class="lang">Login ID</p>
					<input type="text" value="{$data.login_id}" disabled>

					<p class="lang" style="margin-top:10px;">New Password</p>
					<input type="password" name="password" value="">
					<p class="error">{$err_password}</p>

					<p class="lang" style="margin-top:10px;">Confirm Password</p>
					<input type="password" name="password_confirm" value="">
					<p class="error">{$err_password_confirm}</p>

					<button class="loginbutton lang" style="float:right;margin-top:18px;">Update</button>
				</form>
			</div>
		</article>
		{include file="{$base_template_dir}/publicsite_footer.tpl"}
	</body>
</html>
