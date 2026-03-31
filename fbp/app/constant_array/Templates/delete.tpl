<form id="dx_constant_array_delete_form_{$data.id}">

	<input type="hidden" name="id" value="{$data.id}">


	<span class="lang">Delete the following option</span>
	<br>
	<br>

	<p>
		<b>

			{$data.array_name}

		</b>
	</p>

	<br>
	<p class="lang">If you perform this process, it will not be restored. Do you want to process it?</p>

</form>

<button class="ajax-link lang" data-form="dx_constant_array_delete_form_{$data.id}" data-class="{$class}"
		data-function="delete_exe">Delete</button>

