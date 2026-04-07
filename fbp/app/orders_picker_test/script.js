append_function_dialog(function (dialog_id) {
	var root = $(dialog_id);
	var select = root.find("#orders_picker_target");
	var dateWrap = root.find(".orders_picker_test_date");
	var timeWrap = root.find(".orders_picker_test_time");
	var yearMonthWrap = root.find(".orders_picker_test_year_month");
	var dropdownWrap = root.find(".orders_picker_test_dropdown");

	function toggle_fields() {
		var value = select.val();
		dateWrap.hide();
		timeWrap.hide();
		yearMonthWrap.hide();
		dropdownWrap.hide();

		if (value === "date") {
			dateWrap.show();
		} else if (value === "time") {
			timeWrap.show();
		} else if (value === "year_month") {
			yearMonthWrap.show();
		} else if (value === "dropdown") {
			dropdownWrap.show();
		} else if (value === "all") {
			dateWrap.show();
			timeWrap.show();
			yearMonthWrap.show();
			dropdownWrap.show();
		}
	}

	select.off("change.ordersPickerTest").on("change.ordersPickerTest", toggle_fields);
	toggle_fields();
});
