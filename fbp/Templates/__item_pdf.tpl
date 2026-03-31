

このファイルは作りかけです。消しても構いません。（中間　2025.8.30）

{assign name $field["parameter_name"]}
{assign type $field["type"]}
{if $type == "text"}
{$row.$name nofilter}
{else if $type == "number"}
{$row.$name nofilter}
{else if $type == "float"}
{$row.$name nofilter}
{else if $type == "textarea"}
{$row.$name nofilter}
{else if $type == "textarea_links"}
{$row.$name nofilter}
{else if $type == "markdown"}
{$row.$name nofilter}
{else if $type == "dropdown"}
{$field["options"][$row[$name]]}
{else if $type == "date"}
{$row.$name nofilter}
{else if $type == "datetime"}
{$row.$name}
{else if $type == "year_month"}
{$row.$name}
{else if $type == "checkbox"}
	{foreach $field["options"] as $key=>$option}
	    {if is_array($row.$name)}
			{if in_array($key,$row.$name)}
{$option} 
			{/if}
	    {/if}
	{/foreach}	
{else if $type == "radio"}
{$field["options"][$row[$name]]
{else if $type == "image"}
    {if $row[$name]}
{assign file $ctl->get_file_info($row[$name])}
\[image:$file]
    {/if}
{/if}
