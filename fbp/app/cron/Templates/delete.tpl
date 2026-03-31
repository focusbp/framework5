<form id="form_{$timestamp}">

	<input type="hidden" name="id" value="{$data.id}">

	<span class="lang">Delete the following Handler Function</span>
	<p>
		<b>
			{$data.title}
		</b>
	</p>

	<br>
	<p class="lang">If you perform this process, it will not be restored. Do you want to process it?</p>
</form>

<button class="ajax-link lang" data-form="form_{$timestamp}" data-class="{$class}" data-function="delete_exe">Delete</button>

