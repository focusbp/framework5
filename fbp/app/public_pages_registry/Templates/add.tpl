<form id="public_pages_registry_add_form" onsubmit="return false;">
	<table class="custom_events_table">
		<tbody>
			<tr><td style="width:30%;">Title</td><td><input type="text" name="title" value="{$post.title|default:''|escape}"><p class="error_message error_title"></p></td></tr>
			<tr><td>Function Name</td><td><input type="text" name="function_name" value="{$post.function_name|default:''|escape}"><p class="error_message error_function_name"></p></td></tr>
			<tr><td>Show In Menu</td><td>{html_options name="show_in_menu" options=$menu_opt selected=$post.show_in_menu|default:0}</td></tr>
			<tr><td>Menu Label</td><td><input type="text" name="menu_label" value="{$post.menu_label|default:''|escape}"></td></tr>
			<tr><td>Menu Sort</td><td><input type="text" name="menu_sort" value="{$post.menu_sort|default:''|escape}"><p class="error_message error_menu_sort"></p></td></tr>
			<tr><td>Status</td><td>{html_options name="enabled" options=$enabled_opt selected=$post.enabled|default:1}</td></tr>
		</tbody>
	</table>
	<div style="margin-top:10px;">
		<button class="ajax-link" data-class="{$class}" data-function="add_exe" data-form="public_pages_registry_add_form">Save</button>
	</div>
</form>
