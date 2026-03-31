<table style="margin-top:20px;" class="moredata">

	<tbody>
		{foreach $items as $item}
			<tr>
				<td style="width: 75%">{$item.operation_name}</td>
				<td style="display: flex;justify-content: space-between;flex-direction: row-reverse;">
					<button class="ajax-link listbutton" data-class="{$class}" data-function="record_delete" data-id="{$item.id}" style="float:right;color:black;margin-right:5px;"><span class="ui-icon ui-icon-trash"></span></button>
					<button class="ajax-link listbutton" data-class="{$class}" data-function="record_edit" data-id="{$item.id}"  style="float:right;color:black;"><span class="ui-icon ui-icon-pencil"></span></button>
				</td>
			</tr>
		{/foreach}
	</tbody>
</table>
