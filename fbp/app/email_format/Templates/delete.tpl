<center>
	<form id="email_format_email_format_delete_form_{$data.id}">

		<input type="hidden" name="id" value="{$data.id}">

		<span class="lang">Delete the following Email Templates</span>
		<p>
			<b>

				{$data.template_name}

			</b>
		</p>
		<br>
		<p class="lang">If you perform this process, it will not be restored. Do you want to process it?</p>

	</form>

	<div class="flex-full" style="border:none;justify-content: center; margin-top: 15px;margin-bottom: 15px;">
		<button class="cancel_delete lang">No</button>
		<button class="ajax-link lang" data-form="email_format_email_format_delete_form_{$data.id}" data-class="{$class}" data-function="delete_exe">Yes</button>
	</div>

</center>
<script>
	$('.cancel_delete').click(function () {
		$(this).parent().closest(".multi_dialog").children('.multi_dialog_title_area').find('.multi_dialog_close').click();
	});
</script>
