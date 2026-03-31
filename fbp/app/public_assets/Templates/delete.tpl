<form id="public_assets_delete_form" onsubmit="return false;">
	<input type="hidden" name="id" value="{$data.id|default:''}">
	<p>Delete this public asset?</p>
	<table class="custom_events_table">
		<tbody>
			<tr><td>Asset Key</td><td>{$data.asset_key|default:''|escape}</td></tr>
			<tr><td>Original Filename</td><td>{$data.original_filename|default:''|escape}</td></tr>
			<tr><td>Image</td><td>{if $data.preview_url != ''}<div style="width:140px;height:80px;border:1px solid #d1d5db;border-radius:4px;display:flex;align-items:center;justify-content:center;overflow:hidden;background:#000;"><img src="{$data.preview_url}" style="width:100%;height:100%;object-fit:contain;"></div>{/if}</td></tr>
		</tbody>
	</table>
	<div style="margin-top:10px;">
		<button class="ajax-link" data-class="public_assets" data-function="delete_exe" data-form="public_assets_delete_form">Delete</button>
	</div>
</form>
