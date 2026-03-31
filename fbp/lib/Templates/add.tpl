
<form id="form_{$timestamp}">
{if $title != ""}
<h4>{$title}</h4>
{/if}
	
{foreach from=$hidden_params key=name item=value}
    <input type="hidden" name="{$name}" value="{$value}">
{/foreach}
	
    {foreach $group1 as $field}
    <div style="margin-top:10px;">
        {include file="{$base_template_dir}/__item_edit.tpl"}
        <p class="error_message error_{$field["parameter_name"]}" style="margin-top:2px;"></p>
    </div>
    {/foreach}
    
</form>
{if $form_function_name != ""}
	<button class="ajax-link lang" data-form="form_{$timestamp}" data-class="{$class}" data-function="{$form_function_name}">{$form_button_title}</button>
{/if}