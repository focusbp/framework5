<form id="public_assets_edit_form" onsubmit="return false;">
	<input type="hidden" name="id" value="{$data.id|default:''}">
	<table class="custom_events_table">
		<tbody>
			<tr><td style="width:30%;">Replace Image</td><td><input type="file" name="asset_file" accept="image/*"><p style="font-size:12px;color:#6b7280;margin:4px 0 0 0;">差し替える場合のみ選択してください。</p><p class="error_message error_asset_file"></p></td></tr>
			<tr><td>Status</td><td>{html_options name="enabled" options=$enabled_opt selected=$data.enabled|default:1}</td></tr>
		</tbody>
	</table>
	<div style="margin-top:10px;">
		<button class="ajax-link" data-class="public_assets" data-function="edit_exe" data-form="public_assets_edit_form">Save</button>
	</div>
</form>
