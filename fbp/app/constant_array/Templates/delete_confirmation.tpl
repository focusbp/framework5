Are you sure you want to delete this pair?
<p>Value: {$values.key}</p>
<p>Label: {$values.value}</p>
<form id="form{$values.id}">
	<input type="hidden" name="values_id" value="{$values.id}">
</form>
<button class="ajax-link" data-form="form{$values.id}" data-class="{$class}" data-constant_array_id="{$values.constant_array_id}" data-function="delete_values_exe">Delete</button>


