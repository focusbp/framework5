<button class="ajax-link" data-class="{$class}" data-function="add" >Add Button</button>
<div style="clear:both;"></div>
<table style="margin-top:20px;">
	<tr>
		<th>Button Title</th>
		<th>Action Name</th>
		<th>Function Name</th>
		<th>Place</th>
		<th></th>
	</tr>
	{foreach $items as $d}
		<tr>
			<td>{$d.button_title}</td>
			<td class="code_td">{$d.class_name}</td>
			<td class="code_td">{$d.function_name}</td>
			<td class="code_td">{$place_opt[$d.place]}</td>
			<td>
				<button class="ajax-link listbutton" data-class="{$class}" data-function="delete" data-id="{$d.id}" style="float:right;color:black;margin-right:5px;"><span class="ui-icon ui-icon-trash"></span></button>

				<button class="ajax-link listbutton" data-class="{$class}" data-function="edit" data-id="{$d.id}" style="float:right;color:black;"><span class="ui-icon ui-icon-pencil"></span></button>
			</td>
		</tr>
	{/foreach}
</table>
