
{**
This template need the following parameters.
$field : The field format array of db/ai_field.fmt
$row : array of the values.
**}

{assign name $field["parameter_name"]}
{assign type $field["type"]}
{assign title $field["parameter_title"]}

<div class="field_edit">

<h6 class="lang">{$title}</h6>
	
{if $type == "text"}
	
	{if $name == "password"}
		<input type="password" name="{$name}" value="{$row.$name}">		
	{else}
		<input type="text" name="{$name}" value="{$row.$name}">
	{/if}
	
{/if}

</div>
