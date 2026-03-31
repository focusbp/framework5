

<button class="ajax-link lang" data-class="{$class}" data-function="json_upload" style="margin-top: 0px;">JSON Upload</button>
<button class="download-link lang" data-filename="system_setting.json" data-class="{$class}" data-function="json_download" style="margin-top: 0px;">JSON Download</button>  

<form id="setting_form">
	
	<h5 style="margin-top:20px;">Releasing</h5>
	<table>
		<tr>
			<td>Project Release Code</td>
			<td><input type="text" name="project_release_code" value="{$setting.project_release_code}"></td>
		</tr>
	</table>
		
	<h5 style="margin-top:20px;">SSL</h5>
	<table>
		<tr>
			<td>SSL</td>
			<td>{html_options name="ssl" options=$arr_ssl selected=$setting.ssl}</td>
		</tr>
	</table>
		
	<h5 style="margin-top:20px;">Timezone</h5>
	<table>
		<tr>
			<td>Timezone</td>
			<td>
		{html_options name="timezone" options=$timezones selected=$setting.timezone}
			</td>
		</tr>
	</table>

	<h5 style="margin-top:20px;">Mode</h5>
	<table>
		<tr>
			<td>{html_options name="force_testmode" options=$arr_force_testmode selected=$setting.force_testmode}</td>
		</tr>
	</table>
		
	<h5 style="margin-top:20px;">Developer Panel (On Production Mode)</h5>
	<table>
		<tr>
			<td>{html_options name="show_developer_panel" options=$arr_show_developer_panel selected=$setting.show_developer_panel}</td>
		</tr>
	</table>
		
	<h5 style="margin-top:20px;">Source Code Directory (/foo/bar/.../project_folder)</h5>
	<p>This folder contains the classes directory.</p>
	<table>
	  <tr>
		<td>
		  <input type="text" name="source_code_dir" value="{$setting.source_code_dir}">
		</td>
	  </tr>
	</table>
		
	<h5 style="margin-top:20px;">Show the homepage link on the menu</h5>
	<table>
		<tr>
			<td>{html_options name="show_menu_homepage" options=$arr_show_menu selected=$setting.show_menu_homepage}</td>
		</tr>
	</table>


	<h5 style="margin-top:20px;">Rewrite for Root Access</h5>
	<table>
		<tr>
			<td>Class Name (default:login)<input type="text" name="rewrite_rule_root" value="{$setting.rewrite_rule_root}" style="width:200px;"></td>
			<td>Function:<input type="text" name="rewrite_rule_function" value="{$setting.rewrite_rule_function}" style="width:200px;"></td>
		</tr>
	</table>
		
	<h5 style="margin-top:20px;">Default class name in the URL</h5>
	<table>
		<tr>
			<td>Default Class<input type="text" name="default_class_name" value="{$setting.default_class_name}" style="width:200px;"></td>
		</tr>
	</table>

	<h5 style="margin-top:20px;">Startup Class </h5>
	<p>It will be called automatically when you login to management side.</p>
	<table>
		<tr>
			<td>Class:<input type="text" name="startup_class1" value="{$setting.startup_class1}" style="width:200px;"></td>
			<td>Function:<input type="text" name="startup_function1" value="{$setting.startup_function1}" style="width:200px;"></td>
		</tr>
	</table>

	<h5 style="margin-top:20px;">Mail Server Setting</h5>
	<table>
		<tr>
			<td>Mail Address (for from)</td>
			<td><input type="text" name="smtp_from" value="{$setting.smtp_from}"></td>
		</tr>
		<tr>
			<td>Mail Server</td>
			<td><input type="text" name="smtp_server" value="{$setting.smtp_server}"></td>
		</tr>
		<tr>
			<td>Mail Port</td>
			<td><input type="text" name="smtp_port" value="{$setting.smtp_port}"></td>
		</tr>
		<tr>
			<td>Mail User</td>
			<td><input type="text" name="smtp_user" value="{$setting.smtp_user}"></td>
		</tr>
		<tr>
			<td>Mail Password</td>
			<td><input type="text" name="smtp_password" value="{$setting.smtp_password}"></td>
		</tr>
		<tr>
			<td>SMTPSecure</td>
			<td>{html_options name="smtp_secure" options=$arr_smtp_secure selected=$setting.smtp_secure}</td>
		</tr>
		<tr>
			<td>Email for testing</td>
			<td><input type="text" name="smtp_email_test" value="{$setting.smtp_email_test}"></td>
		</tr>

	</table>
	<button class="ajax-link lang" data-class="setting" data-function="update" data-form="setting_form" data-send_test_mail="1">Submit and send a test mail</button>

	<h5 style="margin-top:20px;">Vimeo Setting</h5>
	<table>
		<tr>
			<td>Access Token</td>
			<td><input type="text" name="vimeo_access_token" value="{$setting.vimeo_access_token}"></td>
		</tr>
	</table>

	<h5 style="margin-top:20px;">SQUARE Setting</h5>
	<table>
		<tr>
			<td>Application ID</td>
			<td><input type="text" name="square_application_id" value="{$setting.square_application_id}"></td>
		</tr>
		<tr>
			<td>Access Token</td>
			<td><input type="text" name="square_access_token" value="{$setting.square_access_token}"></td>
		</tr>
		<tr>
			<td>Location ID</td>
			<td><input type="text" name="square_location_id" value="{$setting.square_location_id}"></td>
		</tr>
		<tr>
			<td>Currency</td>
			<td>{html_options name="currency" options=$currency_list selected=$setting.currency}</td>
		</tr>
	</table>
	<p class="ajax-link lang" data-class="setting" data-function="square" style="color:blue;text-decoration: underline;">Square Test (100 Yen)</p>


	<h5 style="margin-top:20px;">Google Settings</h5>
	<table>
		<tr>
			<td>API Key</td>
			<td><input type="text" name="api_key_map" value="{$setting.api_key_map}"></td>
		</tr>
	</table>

	<h5 style="margin-top:20px;">API Authentication (HMAC)</h5>
	<table>
		<tr>
			<td>API Key</td>
			<td><input type="text" name="api_key" value="{$setting.api_key}" readonly></td>
		</tr>
		<tr>
			<td>API Secret</td>
			<td><input type="text" name="api_secret" value="{$setting.api_secret}" readonly></td>
		</tr>
	</table>
		
	<h5 style="margin-top:20px;">LINE Bot Settings</h5>
	<table>
		<tr>
			<td>Webhook URL</td>
			<td><input type="text" value="{$line_webhook_url}" readonly></td>
		</tr>
		<tr>
			<td>Channel Secret</td>
			<td><input type="text" name="line_channel_secret" value="{$setting.line_channel_secret}"></td>
		</tr>
		<tr>
			<td>Channel Access Token</td>
			<td><input type="text" name="line_accesstoken" value="{$setting.line_accesstoken}"></td>
		</tr>
		<tr>
			<td>Log file path</td>
			<td><input type="text" name="line_logfile" value="{$setting.line_logfile}"></td>
		</tr>
		<tr>
			<td>Bot Greeting Message</td>
			<td><textarea name="line_bot_greeting_message">{$setting.line_bot_greeting_message}</textarea></td>
		</tr>
	</table>
		

	<h5 style="margin-top:20px;">OpenAI Settings</h5>
	
	<p>For Bot</p>
	<table>
		<tr>
			<td>API Key</td>
			<td><input type="text" name="chatgpt_api_key" value="{$setting.chatgpt_api_key}"></td>
		</tr>
		<tr>
			<td>Endpoint URL<br /><span style="font-size:10px;">For completions</span></td>
			<td><input type="text" name="chatgpt_api_url" value="{$setting.chatgpt_api_url}"></td>
		</tr>
		<tr>
			<td>Default Model</td>
			<td><input type="text" name="chatgpt_api_model" value="{$setting.chatgpt_api_model}"></td>
		</tr>
	</table>
		
	<p>For Coding</p>
	<table>
		<tr>
			<td>API Key</td>
			<td><input type="text" name="chatgpt_coding_key" value="{$setting.chatgpt_coding_key}"></td>
		</tr>
		<tr>
			<td>Endpoint URL<br /><span style="font-size:10px;">For completions</span></td>
			<td><input type="text" name="chatgpt_coding_url" value="{$setting.chatgpt_coding_url}"></td>
		</tr>
		<tr>
			<td>Default Model</td>
			<td><input type="text" name="chatgpt_coding_model" value="{$setting.chatgpt_coding_model}"></td>
		</tr>
	</table>
	
	<p>Common</p>
	<table>
		<tr>
			<td>Log File</td>
			<td><input type="text" name="openai_logfile" value="{$setting.openai_logfile}"></td>
		</tr>
		<tr>
			<td>Max Vector Store Files</td>
			<td><input type="text" name="max_vs" value="{$setting.max_vs}"></td>
		</tr>
	</table>
		
	<p>Endpoints for completions</p>
	<table>
		<tr>
			<td>OpenAI</td>
			<td>https://api.openai.com/v1/chat/completions</td>
		</tr>
		<tr>
			<td>Sakura</td>
			<td>https://api.ai.sakura.ad.jp/v1/chat/completions</td>
		</tr>
	</table>

	<h5 style="margin-top:20px;">Language</h5>
	<table>
		<tr>
			<td>Priority</td>
			<td>{html_options name="lang_priority" options=$arr_lang_priority selected=$setting.lang_priority}</td>
		</tr>
		<tr>
			<td>Default Language</td>
			<td>{html_options name="lang_default" options=$arr_lang selected=$setting.lang_default}</td>
		</tr>
		<tr>
			<td>Show Dropdown on chat</td>
			<td>{html_options name="flg_show_lang_on_chat" options=$arr_flg_show_lang_on_chat selected=$setting.flg_show_lang_on_chat}</td>
		</tr>
	</table>

	<h5 style="margin-top:20px;">Encrypt/Decrypt</h5>
	<table>
		<tr>
			<td>Secret</td>
			<td><input type="text" name="secret" value="{$setting.secret}"></td>
		</tr>
		<tr>
			<td>IV</td>
			<td><input type="text" name="iv" value="{$setting.iv}"></td>
		</tr>
	</table>

	<h5 style="margin-top:20px;">Robots.txt</h5>
	<table>
		<tr>
			<td>robots.txt</td>
			<td><textarea name="robots">{$setting.robots}</textarea></td>
		</tr>
	</table>
		
	<h5 style="margin-top:20px;">Viewport</h5>
	<table>
		<tr>
			<td>Management Side</td>
			<td><input type="text" name="viewport_base" value="{$setting.viewport_base}"></td>
		</tr>
		<tr>
			<td>Public Side</td>
			<td><input type="text" name="viewport_public" value="{$setting.viewport_public}"></td>
		</tr>
	</table>

	<h5 style="margin-top:20px;">System Name</h5>
	<table>
		<tr>
			<td>System Name {literal}{$setting.system_name}{/literal}</td>
			<td><input type="text" name="system_name" value="{$setting.system_name}"></td>
		</tr>
		<tr>
			<td>System Tag Line</td>
			<td><input type="text" name="system_tag_line" value="{$setting.system_tag_line}"></td>
		</tr>
		<tr>
			<td>Login Logo</td>
			<td><input type="file" name="login_logo" class="fr_image_paste" data-text="Image Uploader">
				<br /><button class="ajax-link" data-class="{$class}" data-function="delete_login_logo" style="margin-top:0px;">Delete Login Logo</button>
			</td>
		</tr>
		<tr>
			<td>favicon.ico</td>
			<td><input type="file" name="favicon" class="fr_image_paste" data-text="Image Uploader">
				<br /><button class="ajax-link" data-class="{$class}" data-function="delete_favicon" style="margin-top:0px;">Delete favicon</button>
			</td>
		</tr>
	</table>

	<h5 style="margin-top:20px;">Website</h5>
	<table>
		<tr>
			<td>Website URL</td>
			<td><input type="text" name="website_url" value="{$setting.website_url}"></td>
		</tr>
	</table>

</form>
		
		
<button class="ajax-link lang" data-class="setting" data-function="update" data-form="setting_form">Submit</button>

<div style="clear:both;margin-bottom:30px;"></div>
