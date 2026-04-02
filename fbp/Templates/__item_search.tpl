
{**
This template need the following parameters.
$field : The field format array of db/ai_field.fmt
$row : array of the values.
**}

{assign name $field["parameter_name"]}
{assign type $field["type"]}
{assign title $field["parameter_title"]}

<div class="field_edit" data-parameter-name="{$name|escape}" data-parameter-title="{$title|escape}" data-field-type="{$type|escape}">

<h6 class="lang">{$title}</h6>
	
{if $type == "text"}
	
	<input type="text" name="{$name}" value="{$row.$name}" data-search-name="{$name|escape}" data-search-title="{$title|escape}" data-search-type="{$type|escape}">
	
	
{else if $type == "number"}
	{if $name != "id"}
		
		<input type="text" name="{$name}" value="{$row.$name}" data-search-name="{$name|escape}" data-search-title="{$title|escape}" data-search-type="{$type|escape}">
	{/if}
	
{else if $type == "float"}
	
	<input type="text" name="{$name}" value="{$row.$name}" data-search-name="{$name|escape}" data-search-title="{$title|escape}" data-search-type="{$type|escape}">
	
{else if $type == "textarea"}
	
	{if $field.max_bytes > 0}
		<textarea name="{$name}" class="wordcounter" data-counter_max="{$field.max_bytes}" data-search-name="{$name|escape}" data-search-title="{$title|escape}" data-search-type="{$type|escape}">{$row.$name}</textarea>
	{else}
		<textarea name="{$name}" data-search-name="{$name|escape}" data-search-title="{$title|escape}" data-search-type="{$type|escape}">{$row.$name}</textarea>
	{/if}
	
{else if $type == "textarea_links"}
	
	{if $field.max_bytes > 0}
		<textarea name="{$name}" class="wordcounter" data-counter_max="{$field.max_bytes}" data-search-name="{$name|escape}" data-search-title="{$title|escape}" data-search-type="{$type|escape}">{$row.$name}</textarea>
	{else}
		<textarea name="{$name}" data-search-name="{$name|escape}" data-search-title="{$title|escape}" data-search-type="{$type|escape}">{$row.$name}</textarea>
	{/if}
	
{else if $type == "markdown"}
	
	{if $field.max_bytes > 0}
		<textarea name="{$name}" class="wordcounter" data-counter_max="{$field.max_bytes}" data-search-name="{$name|escape}" data-search-title="{$title|escape}" data-search-type="{$type|escape}">{$row.$name}</textarea>
	{else}
		<textarea name="{$name}" data-search-name="{$name|escape}" data-search-title="{$title|escape}" data-search-type="{$type|escape}">{$row.$name}</textarea>
	{/if}
	
{else if $type == "dropdown"}
	{html_options name=$name options=$field["options"] selected=$row[$name]}

{else if $type == "checkbox"}
	<select name="{$name}">
		<option value=""></option>
		{foreach $field["options"] as $key=>$option}
			<option value="{$key|escape}" {if $row[$name] == $key}selected{/if}>{$option}</option>
		{/foreach}
	</select>
	
{else if $type == "date"}
	
	{html_input_date name="{$name}" value="{$row.$name}" style="padding-left:20px;"}
	
{else if $type == "datetime"}
	<input type="text" name="{$name}" value="{$row.$name}" class="world_datetime" data-search-name="{$name|escape}" data-search-title="{$title|escape}" data-search-type="{$type|escape}">
	
{else if $type == "year_month"}
	
	<input type="text" name="{$name}" value="{$row.$name}" class="year_month_picker" data-search-name="{$name|escape}" data-search-title="{$title|escape}" data-search-type="{$type|escape}">	
			
{else if $type == "radio"}
	{html_radios name="{$name}" options=$field["options"] selected=$row[$name] class="checkboxradio"}
	
{else if $type == "color"}
	
	<input type="text" name="{$name}" value="{$row[$name]}" class="colorpicker" data-search-name="{$name|escape}" data-search-title="{$title|escape}" data-search-type="{$type|escape}">
		
{else}
	<p>This item cannot be used as a search field.</p>

{/if}

<span class="error">{$errors[$name]}</span>

</div>
