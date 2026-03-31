
<form id="form_{$timestamp}">
{if $title != ""}
<h4>{$title}</h4>
{/if}
	
    <input type="hidden" name="id" value="{$row.id}">
{foreach from=$hidden_params key=name item=value}
    <input type="hidden" name="{$name}" value="{$value}">
{/foreach}
</form>
{foreach $group1 as $field}
<div class="row_style" style="margin-top:10px;">
    <span class="row_title">{$field["parameter_title"]}</span>
    {include file="{$base_template_dir}/__item_viewer.tpl"}
    <p class="error_message error_{$field["parameter_name"]}" style="margin-top:0px;"></p>
</div>
{/foreach}
{if $form_function_name != ""}
	<button class="ajax-link lang" data-form="form_{$timestamp}" data-class="{$class}" data-function="{$form_function_name}">{$form_button_title}</button>
{/if}

