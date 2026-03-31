<form id="public_pages_registry_edit_form" onsubmit="return false;">
	<input type="hidden" name="id" value="{$data.id|default:''}">
	<input type="hidden" name="function_name" value="{$data.function_name|default:''|escape}">
	<table class="custom_events_table">
		<tbody>
			<tr><td style="width:30%;">Title</td><td><input type="text" name="title" value="{$data.title|default:''|escape}"><p class="error_message error_title"></p></td></tr>
			<tr><td>Show In Menu</td><td>{html_options name="show_in_menu" options=$menu_opt selected=$data.show_in_menu|default:0}</td></tr>
			<tr><td>Menu Label</td><td><input type="text" name="menu_label" value="{$data.menu_label|default:''|escape}"></td></tr>
			<tr><td>Status</td><td>{html_options name="enabled" options=$enabled_opt selected=$data.enabled|default:1}</td></tr>
		</tbody>
	</table>
	<div style="margin-top:10px;">
		<button class="ajax-link" data-class="{$class}" data-function="edit_exe" data-form="public_pages_registry_edit_form">Save</button>
	</div>
</form>
