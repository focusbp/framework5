<form id="form_add_operation_name">
    <input type="hidden" name="record_data"value="{$post.record_data}">
	<div>
		<span class="lang">Record Name</span>
		<input type="text" name="operation_name" value="{$post.operation_name}">
		<p class="error">{$errors['operation_name']}</p>
	</div>


	<div>
		<button class="ajax-link lang" data-form="form_add_operation_name" data-class="{$class}"
				data-function="record_exe">Submit</button>
	</div>

</form>