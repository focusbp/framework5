
<form id="vimeo_upload_form">
	<input type="hidden" name="callback_parameter_array" value="{$callback_parameter_array}">
	<div class="vimeo_upload_area">
		<p>{t key="vimeo.video_title"}</p>
		<input type="text" name="vimeo_title" id="vimeo_title">
		<p>{t key="vimeo.video_description"}</p>
		<textarea name="vimeo_description" id="vimeo_description"></textarea>

		<div style="width:50%;float:left;">
			<p>{t key="vimeo.select_upload_file"}</p>
			<input id="sliced_file" type="file" data-mode="vimeo" />
		</div>
		<div style="width:50%;float:left;">
			<p>{t key="vimeo.id_url"}</p>
			<input type="text" id="vimeo_id" name="vimeo_id" style="margin-top:0px;">
		</div>
		<p class="error" id="sliced_error"></p>
		<div style="clear:both;"></div>
		<p style="line-height:1em;font-size: 80%;">{t key="vimeo.help.already_uploaded"}</p>
	</div>
</form>

<button id="vimeo_send_button" class="ajax-link" data-class="{$callback_class_name}" data-function="{$callback_function_name}" data-form="vimeo_upload_form">{t key="vimeo.register_video"}</button>

<div style="margin-bottom:80px;"></div>

