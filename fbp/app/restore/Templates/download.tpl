
{if $flg}
	<p>{$message}</p>

	<form id="form_{$timestamp}">
		<p>Memo</p>
		<textarea name="memo"></textarea>
	</form>

	<button class="download-link" data-form="form_{$timestamp}" data-class="restore" data-function="download_zip_exe" data-filename="restore-{$setting.project_release_code}-{date("Ymd")}.zip">Download</button>
{else}
	<p class="error">{$message}</p>
{/if}


