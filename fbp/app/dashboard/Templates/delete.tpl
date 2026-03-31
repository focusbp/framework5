<form>
	<input type="hidden" name="id" value="{$data.id}">
	<span>Delete the following widget</span>
	<p><b>{$data.class_name} / {$data.function_name}</b></p>
	<br>
	<p>If you perform this process, it will not be restored. Do you want to process it?</p>
	<button class="ajax-link lang" data-class="{$class}" data-function="delete_exe">Delete</button>
</form>
