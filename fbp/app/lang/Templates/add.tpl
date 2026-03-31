<form id="lang_add_form">
	<table>
		<tr>
			<td>Class</td>
			<td><input type="text" name="classname" value="{$post.classname}"></td>
		</tr>
		<tr>
			<td>English</td>
			<td><input type="text" name="en" value="{$post.en}"></td>
		</tr>
		<tr>
			<td>Japanese</td>
			<td><input type="text" name="jp" value="{$post.jp}"></td>
		</tr>
	</table>

	<div style="margin-top:10px;">
		<button class="ajax-link" data-class="lang" data-function="add_exe" data-form="lang_add_form">Add</button>
	</div>
</form>
