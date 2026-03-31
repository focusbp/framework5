<form id="dbs_db_fields_add_form">

	<input type="hidden" name="db_id" value="{$post.db_id}">
	<div>
		<p class="lang">Field Title:</p>
		<input type="text" name="parameter_title" value="{$post.parameter_title}">

		<p class="error_message lang error_parameter_title"></p>
	</div>	
	<div>
		<p class="lang">Field Name:</p>
		<input type="text" name="parameter_name" value="{$post.parameter_name}">

		<p class="error_message lang error_parameter_name"></p>
	</div>
	<div>
		<p class="lang">Field Description:</p>
		<input type="text" name="parameter_description" value="{$post.parameter_description}">
		<p class="error_message lang error_parameter_description"></p>
	</div>
		
	<div>
		<p class="lang">Field Description For Bot (Usually you can leave this blank.):</p>
		<input type="text" name="parameter_description_bot" value="{$post.parameter_description_bot}">
		<p class="error_message lang error_parameter_description_bot"></p>
	</div>

	<div>
		<p class="lang">Field Type:</p>
		{html_options name="type" id="type_event" selected=$post.type options=$type_opt}
	</div>

	<div id="area_option">
		{include file="_area_option.tpl"}
	</div>

		
	<div class="image_width">
		<p class="lang">Image Width:</p>
		<input class="image_width" type="text" name="image_width" value="{$post.image_width}">
	</div>
	
	<div class="image_width">
		<p class="lang">Thumbnail Width:</p>
		<input type="text" name="image_width_thumbnail" value="{$post.image_width_thumbnail}">
	</div>

	<div>
		<p class="lang">Validation:</p>
		{html_options name="validation" selected=$post.validation options=$validation_opt}
	</div>
	<div>
		<p class="lang">Duplicate Check (Applicable to text/number/year_month fields):</p>
		{html_options name="duplicate_check" selected=$post.duplicate_check options=$duplicate_check_opt}
	</div>
	<div>
		<p class="lang">Format Check (Applicable to text fields only):</p>
		{html_options name="format_check" selected=$post.format_check options=$format_check_title_opt}
	</div>
	<div>
		<p class="lang">Default:</p>
		<input type="text" name="default_value" value="{$post.default_value}">
	</div>
	
	<div>
		<p class="lang">Title Color:</p>
		<input type="text" name="title_color" value="{$post.title_color}" class="colorpicker">
	</div>


	<div>
		<button class="ajax-link lang" data-form="dbs_db_fields_add_form" data-class="{$class}" data-function="add_fields_exe">Add</button>
	</div>

</form>
