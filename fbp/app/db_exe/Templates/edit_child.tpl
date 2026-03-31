
<form id="form_{$timestamp}">
	
	<input type="hidden" name="id" value="{$row.id}">
	
	{foreach $group1 as $field}
		<div style="margin-top:10px;">
			{include file="{$base_template_dir}/__item_edit.tpl"}
			<p class="error_message error_{$field["parameter_name"]}" style="margin-top:0px;"></p>
		</div>
	{/foreach}
	
</form>
