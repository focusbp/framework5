
{**
This template need the following parameters.
$field : The field format array of db/ai_field.fmt
$row : array of the values.
**}

{assign name $param["parameter_name"]}
{assign type $param['type']}
{assign title $param["parameter_title"]}
{assign row $list_data}

{if $type == "text"}
	<p>{$title}: {$row.$name}</p>
	
{else if $type == "number"}
	<p style="white-space: nowrap;text-align: right;">{$title}: {$row.$name|number_format}</p>
	
{else if $type == "float"}
	<p style="white-space: nowrap;text-align: right;">{$title}: {$row.$name}</p>
	
{else if $type == "textarea"}
	<p>{$title}: {$row.$name|nl2br|escape nofilter}</p>

	
{else if $type == "textarea_links"}
	<p>{$title}: {$row.$name|nl2br|url_link nofilter}</p>
	
{else if $type == "markdown"}
	<p>{$title}: {$row.$name|markdown nofilter}</p>
	
{else if $type == "dropdown"}
	<p>{$title}: {$field["options"][$row[$name]]}</p>
	
{else if $type == "date"}
	<p style="white-space: nowrap;text-align: center;">{$title}: {html_date value=$row.$name}</p>
	
{else if $type == "datetime"}
	<p class="world_datetime">{$row.$name}</p>
	
{else if $type == "year_month"}
	<p style="white-space: nowrap;text-align: center;">{$title}: {$row.$name}</p>
	
{else if $type == "checkbox"}
	<p>{$title}: <span style='background: #{$item_setting[$name]["options"][$row[$name]]["color"]};padding:7px;white-space:nowrap;'>{$row.$name}</span></p>
			
{else if $type == "radio"}
	<p style="text-align: center;"><span style='background: #{$item_setting[$name]["options"][$row[$name]]["color"]};padding:7px;white-space:nowrap;'>{$title}: {$field["options"][$row[$name]]}</span></p>
	
{else if $type == "color"}
	<p>{$title}: {$row[$name]}</p>

{else if $type == "vimeo"}
    {if $row[$name] != ""}
	<p>{$title}: https://vimeo.com/{$row[$name]}</p>
    {/if}
    
{/if}

