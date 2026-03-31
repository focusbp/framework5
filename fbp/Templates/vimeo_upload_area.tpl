
<form id="vimeo_upload_form">
	<input type="hidden" name="callback_parameter_array" value="{$callback_parameter_array}">
	<div class="vimeo_upload_area">
		<p class="lang">Video Title</p>
		<input type="text" name="vimeo_title" id="vimeo_title">
		<p class="lang">Video Description</p>
		<textarea name="vimeo_description" id="vimeo_description"></textarea>

		<div style="width:50%;float:left;">
			<p class="lang">Select Upload File</p>
			<input id="sliced_file" type="file" data-mode="vimeo" />
		</div>
		<div style="width:50%;float:left;">
			<p class="lang">Vimeo ID (URL)</p>
			<input type="text" id="vimeo_id" name="vimeo_id" style="margin-top:0px;">
		</div>
		<p class="error" id="sliced_error"></p>
		<div style="clear:both;"></div>
		<p class="lang" style="line-height:1em;font-size: 80%;">If the video has already been uploaded to Vimeo, there is no need to specify a video file. Simply paste the video URL in the text box.</p>
	</div>
</form>

<button id="vimeo_send_button" class="ajax-link lang" data-class="{$callback_class_name}" data-function="{$callback_function_name}" data-form="vimeo_upload_form">Regist Video</button>

<div style="margin-bottom:80px;"></div>


