<div>
	<div style="float:right;margin-bottom: 8px;">
		<button class="ajax-link lang" data-class="{$class}" data-function="add">Add Option</button>
	</div>
</div>

<div style="clear:both;"></div>


<table style="margin-top:20px;" class="moredata">
	<thead>
		<tr class="table-head">
			<th class="lang" style="width: 20%;">Option Name</th>

			<th style="width: 20%;"></th>
		</tr>
	</thead>

	<tbody>
		{foreach $items as $item}
			<tr>

				<td>{$item.array_name}</td>

				<td>

					<button class="ajax-link listbutton" data-class="{$class}" data-function="delete" data-id="{$item.id}" style="float:right;color:black;margin-right:5px;"><span class="ui-icon ui-icon-trash"></span></button>
					<button class="ajax-link listbutton" data-class="{$class}" data-function="edit" data-id="{$item.id}" style="float:right;color:black;"><span class="ui-icon ui-icon-pencil"></span></button>
				</td>
			</tr>
		{/foreach}
	</tbody>
</table>



