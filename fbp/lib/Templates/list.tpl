{if $title != ""}
<h4>{$title}</h4>
{/if}

{if $form_function_name != ""}
<button class="ajax-link lang" data-form="form_{$timestamp}" data-class="{$class}" data-function="{$form_function_name}">{$form_button_title}</button>
{/if}

<div style="clear:both;"></div>

<table style="margin-top:10px;">
    <tbody>
        {foreach $rows as $row}
        <tr{if $row["_color"] != null} style="background:{$row['_color']};"{/if}>
            {foreach $group1 as $field}
            <td class="row_style">
                <span class="row_title">{$field["parameter_title"]}</span>
                <span class="row_value">{include file="{$base_template_dir}/__item_viewer.tpl"}</span>
            </td>
            {/foreach}
            <td>
				{foreach $row["_buttons"] as $button}
					{if $button.title == "edit" || $button.title == "delete"}
                <button class="ajax-link listbutton" data-class="{$class}" data-function="{$button.function_name}" data-id="{$row.id}"><span class="material-symbols-outlined">{$button.title}</span></button>
					{else}
                <button class="ajax-link" data-class="{$class}" data-function="{$button.function_name}" data-id="{$row.id}">{$button.title}</button>
					{/if}
				{/foreach}
            </td>
        </tr>
        {/foreach}
    </tbody>
</table>

{if $flg_show_more_button}
	<a class="ajax-link lang show_more_button" data-class="{$class}" data-function="{$show_more_button_function_name}" data-max="{$max}"
    {foreach from=$show_more_button_parameters key=key item=value}
        data-{$key}="{$value|escape}"
    {/foreach}
	>{$show_more_button_title}</a>
{/if}
	