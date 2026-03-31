<form id="record_delete_form_{$data.id}">

	<input type="hidden" name="id" value="{$data.id}">

	<span class="lang">Are you sure to delete the following record?</span>
	<p>
		<b>

			{$data.operation_name}

		</b>
	</p>
	<br>
	<p class="lang">If you perform this process, it will not be restored. Do you want to process it?</p>

</form>
<button class="cancel_delete lang">No</button>
<button class="ajax-link lang" data-form="record_delete_form_{$data.id}" data-class="{$class}" data-function="record_delete_exe">Delete</button>

<script>
	$('.cancel_delete').click(function () {
		$(this).parent().closest(".multi_dialog").children('.multi_dialog_title_area').find('.multi_dialog_close').click();
	});
</script>
