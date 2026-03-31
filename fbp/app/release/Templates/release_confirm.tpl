
<table style="margin-bottom:10px;">
	<tr>
		<td>Project Release Code</td>
		<td>{$info.project_release_code}</td>
	</tr>
	<tr>
		<td>Date Time</td>
		<td>{$info.datetime}</td>
	</tr>
	<tr>
		<td>Timezone</td>
		<td>{$info.timezone}</td>
	</tr>
	<tr>
		<td>Memo</td>
		<td>{$info.memo}</td>
	</tr>
	<tr>
		<td>Type</td>
		<td>{$info.type}</td>
	</tr>
</table>
{if $flg}

	<button class="ajax-link lang" data-class="{$class}" data-function="release_exe">Release</button>
{else}
	<p class="error">{$message}</p>
{/if}







