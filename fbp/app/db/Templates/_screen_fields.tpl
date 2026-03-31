
<div class="screen_field_list">
	{foreach $screen_fields_arr as $key=>$parameter_name}
		<div class="screen_field" id="{$key}">
			<p><span class="ui-icon ui-icon-arrowthick-2-n-s screen_field_handle"></span>{$parameter_name} <span class="screen_field_delete ajax-link" data-class="{$class}" data-function="delete_screen_field" data-id="{$key}">x</span></p>
		</div>
	{/foreach}
</div>
