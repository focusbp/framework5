<form id="public_pages_registry_delete_form" onsubmit="return false;">
	<input type="hidden" name="id" value="{$data.id|default:''}">
	<p>Delete this public page registry entry?</p>
	<table class="custom_events_table">
		<tbody>
			<tr><td style="width:35%;">Title</td><td>{$data.title|default:''|escape}</td></tr>
			<tr><td>Function Name</td><td>{$data.function_name|default:''|escape}</td></tr>
		</tbody>
	</table>
	<div style="margin-top:10px;">
		<button class="ajax-link" data-class="{$class}" data-function="delete_exe" data-form="public_pages_registry_delete_form">Delete</button>
	</div>
</form>
