<form id="panel_constants_edit_form_{$data.id}">
	<input type="hidden" name="id" value="{$data.id}">

	<div>
		<h6 class="lang">Array Name (must end with "_opt")</h6>
		<input type="text" name="array_name" value="{$data.array_name}">
		<p class="error_message lang error_array_name"></p>
	</div>

	<div class="flex-between" style="margin-top:14px;">
		<h6 class="lang">Value / Label Pairs</h6>
	</div>
	<p class="error_message lang error_rows"></p>

	<table class="moredata" style="margin-top:6px;">
		<thead>
			<tr class="table-head">
				<th style="width:7%;"></th>
				<th class="lang" style="width:18%;">Value(ID)</th>
				<th class="lang" style="width:45%;">Label</th>
				<th class="lang" style="width:20%;">Color</th>
				<th style="width:10%;"></th>
			</tr>
		</thead>
		<tbody id="pc_rows_{$data.id}">
			{foreach $values as $v}
				<tr>
					<td><span class="ui-icon ui-icon-arrowthick-2-n-s pc-handle"></span></td>
					<td>
						<input type="hidden" name="value_id[]" value="{$v.id}">
						<input type="text" name="value_key[]" value="{$v.key}" style="width:95%;">
					</td>
					<td><input type="text" name="value_label[]" value="{$v.value}" style="width:98%;"></td>
					<td><input type="text" name="value_color[]" value="{$v.color}" class="colorpicker" style="width:95%;"></td>
					<td><button type="button" class="ui-button ui-corner-all pc-delete-row" style="margin-top:0;">Delete</button></td>
				</tr>
			{/foreach}
		</tbody>
	</table>

	<div style="margin-top:8px;">
		<button type="button" id="pc_add_row_{$data.id}" class="ui-button ui-corner-all lang" style="margin-top:0;">Add Empty Row</button>
	</div>

</form>

<script>
(function () {
	var tableId = "#pc_rows_{$data.id}";
	var addBtnId = "#pc_add_row_{$data.id}";

	function rowHtml() {
		return '' +
			'<tr>' +
				'<td><span class="ui-icon ui-icon-arrowthick-2-n-s pc-handle"></span></td>' +
				'<td>' +
					'<input type="hidden" name="value_id[]" value="0">' +
					'<input type="text" name="value_key[]" value="" style="width:95%;">' +
				'</td>' +
				'<td><input type="text" name="value_label[]" value="" style="width:98%;"></td>' +
				'<td><input type="text" name="value_color[]" value="#FFF" class="colorpicker" style="width:95%;"></td>' +
				'<td><button type="button" class="ui-button ui-corner-all pc-delete-row" style="margin-top:0;">Delete</button></td>' +
			'</tr>';
	}

	$(tableId).sortable({
		handle: ".pc-handle",
		axis: "y"
	});

	$(document).off("click", addBtnId).on("click", addBtnId, function () {
		var $row = $(rowHtml());
		$(tableId).append($row);
		$row.find(".colorpicker").asColorPicker();
	});

	$(document).off("click", tableId + " .pc-delete-row").on("click", tableId + " .pc-delete-row", function () {
		$(this).closest("tr").remove();
	});
})();
</script>
