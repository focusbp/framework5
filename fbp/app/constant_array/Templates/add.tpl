<form id="dx_constant_array_add_form">

	<div style="">
		<div style="padding:5px;">
			<p class="lang">Option Name(This name should end with "_opt"):</p>
			<input type="text" name="array_name" value="{$post.array_name}">
			<p class="error lang">{$errors['array_name']}</p>
		</div>
	</div>

	<div>
		<button class="ajax-link lang" data-form="dx_constant_array_add_form" data-class="{$class}"
				data-function="add_exe">Add</button>
	</div>

</form>