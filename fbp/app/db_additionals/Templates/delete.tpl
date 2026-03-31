
<form>

	<input type="hidden" name="id" value="{$data.id}">

	<span class="lang">Delete the following data</span>
	<p>
		<b>
			{$data.button_title}
		</b>
	</p>

	<br>
	<p class="lang">If you perform this process, it will not be restored. Do you want to process it?</p>

	<button class="ajax-link lang" data-class="{$class}" data-function="delete_exe" data-reload_db_id="{$reload_db_id}">Delete</button>
</form>


