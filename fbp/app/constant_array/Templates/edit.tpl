<form id="dx_constant_array_edit_form_{$data.id}">

	<input type="hidden" name="id" value="{$data.id}">

	<div style="">
			<h6 class="lang">Option Name (must end with “_opt”)</h6>
			<input type="text" name="array_name" value="{$data.array_name}">
			<p class="error_message lang error_array_name"></p>
		<button class="ajax-link lang" data-form="dx_constant_array_edit_form_{$data.id}" data-class="{$class}"
				data-function="edit_exe" style="margin-top:2px;">Update</button>
	</div>


<div>
	<div class="flex-between" style="width:100%;">
		<div class="" style=""><h6 class="lang">Value–Label Pairs</h6></div>
	</div>
</div>
<p class="error_message lang error_rows"></p>

<table style="margin-top:2px;" class="moredata">
	<tr class="table-head">
		<th style="width: 10%;"></th>
		<th class="lang" style="width: 10%;">Value(ID)</th>
		<th class="lang" style="width: 50%;">Label</th>
		<th class="lang" style="width: 20%;">Color</th>
		<th style="width: 10%;"></th>
	</tr>

	<tbody id="ca_rows_{$data.id}">
	{foreach $values as $key => $note}
		<tr style="background-color:#fff;">
			<td><span class="ui-icon ui-icon-arrowthick-2-n-s ca-handle"></span></td>
			<td>
				<input type="hidden" name="value_id[]" value="{$note.id}">
				<input type="text" name="value_key[]" value="{$note.key}" style="width:95%;">
			</td>
			<td><input type="text" name="value_label[]" value="{$note.value}" style="width:98%;"></td>
			<td><input type="text" name="value_color[]" value="{$note.color}" class="colorpicker" style="width:95%;"></td>
			<td>
				<button type="button" class="ui-button ui-corner-all ca-delete-row" style="margin-top:0;">Delete</button>
			</td>
		</tr>
	{/foreach}
	</tbody>

</table>

<div style="margin-top:8px;">
	<button type="button" id="ca_add_row_{$data.id}" class="ui-button ui-corner-all lang" style="margin-top:0;">Add Empty Row</button>
</div>

</form>

<script>
(function () {
	var tableId = "#ca_rows_{$data.id}";
	var addBtnId = "#ca_add_row_{$data.id}";

	function rowHtml() {
		return '' +
			'<tr style="background-color:#fff;">' +
				'<td><span class="ui-icon ui-icon-arrowthick-2-n-s ca-handle"></span></td>' +
				'<td>' +
					'<input type="hidden" name="value_id[]" value="0">' +
					'<input type="text" name="value_key[]" value="" style="width:95%;">' +
				'</td>' +
				'<td><input type="text" name="value_label[]" value="" style="width:98%;"></td>' +
				'<td><input type="text" name="value_color[]" value="#FFF" class="colorpicker" style="width:95%;"></td>' +
				'<td><button type="button" class="ui-button ui-corner-all ca-delete-row" style="margin-top:0;">Delete</button></td>' +
			'</tr>';
	}

	$(tableId).sortable({
		handle: ".ca-handle",
		axis: "y"
	});

	$(document).off("click", addBtnId).on("click", addBtnId, function () {
		var $row = $(rowHtml());
		$(tableId).append($row);
		$row.find(".colorpicker").asColorPicker();
	});

	$(document).off("click", tableId + " .ca-delete-row").on("click", tableId + " .ca-delete-row", function () {
		$(this).closest("tr").remove();
	});
})();
</script>
