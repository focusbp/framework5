

{if $flg}
	<p>{$message}</p>
	<form method="post" id="release_upload_file">
		<div class="flex-container">
		<div class="flex-full">


			<input type="file" name="release_file" data-text="File Upload" class="fr_image_paste">

		</div>

		</div>
		<button class="ajax-link lang" data-form="release_upload_file" data-class="{$class}" data-function="release_confirm">Release</button>
	</form>
{else}
	<p class="error">{$message}</p>
{/if}







