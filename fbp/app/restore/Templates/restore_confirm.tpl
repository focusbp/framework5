<form id="restore_confirm_form" onsubmit="return false;">
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

	<div style="margin-bottom:10px;">
		<label>
			<input type="checkbox" name="restore_user_data" value="1">
			Restore User Data
		</label>
	</div>

	<div style="margin-bottom:10px;">
		<label>
			<input type="checkbox" name="restore_setting" value="1">
			Restore Setting
		</label>
	</div>
</form>

{if $flg}
	<button class="ajax-link lang" data-form="restore_confirm_form" data-class="{$class}" data-function="restore_exe">Restore</button>
{else}
	<p class="error">{$message}</p>
{/if}
