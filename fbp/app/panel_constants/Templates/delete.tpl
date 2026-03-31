<form id="panel_constants_delete_form_{$data.id}">
	<input type="hidden" name="id" value="{$data.id}">
	<p class="lang">Delete <strong>{$data.array_name}</strong> and all key/value rows?</p>
	<button class="ajax-link lang" data-form="panel_constants_delete_form_{$data.id}" data-class="{$class}" data-function="delete_exe">Delete</button>
</form>
