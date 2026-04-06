append_function_dialog(function (dialog_id) {
	var root = $(dialog_id);
	var select = root.find("#orders_picker_target");
	var dateWrap = root.find(".orders_picker_test_date");
	var timeWrap = root.find(".orders_picker_test_time");
	var originalTimeWrap = root.find(".orders_picker_test_original_time");
	var yearMonthWrap = root.find(".orders_picker_test_year_month");
	var originalTimeInput = root.find(".orders-original-time-input");
	var panelClass = ".orders-original-time-panel";

	function get_original_time_picker_mode() {
		var timeFormat = typeof get_server_time_format === "function" ? get_server_time_format() : "H:i";
		return {
			format: timeFormat,
			usesMeridiem: /[gaA]/.test(timeFormat),
			uppercaseMeridiem: /A/.test(timeFormat),
			padHour: /h/.test(timeFormat)
		};
	}

	function parse_original_time_value(value, mode) {
		if (typeof parse_time_string_by_format === "function") {
			var parsedByFormat = parse_time_string_by_format(value, mode.format);
			if (parsedByFormat) {
				var parsedHour24 = parseInt(parsedByFormat.hour, 10);
				var parsedMinute = String(parsedByFormat.minute).padStart(2, "0");
				if (mode.usesMeridiem) {
					var parsedMeridiem = parsedHour24 >= 12 ? "PM" : "AM";
					var parsedHour12 = parsedHour24 % 12;
					if (parsedHour12 === 0) {
						parsedHour12 = 12;
					}
					return {
						hour: String(parsedHour12),
						minute: parsedMinute,
						meridiem: parsedMeridiem
					};
				}
				return {
					hour: String(parsedHour24).padStart(2, "0"),
					minute: parsedMinute,
					meridiem: "AM"
				};
			}
		}

		if (mode.usesMeridiem) {
			var match12 = value.match(/^\s*(\d{1,2}):(\d{2})\s*([AaPp][Mm])\s*$/);
			if (match12) {
				return {
					hour: String(parseInt(match12[1], 10)),
					minute: match12[2],
					meridiem: match12[3].toUpperCase()
				};
			}
		}

		var match24 = value.match(/^\s*(\d{1,2}):(\d{2})\s*$/);
		if (match24) {
			var hour24 = parseInt(match24[1], 10);
			if (mode.usesMeridiem) {
				var meridiem = hour24 >= 12 ? "PM" : "AM";
				var hour12 = hour24 % 12;
				if (hour12 === 0) {
					hour12 = 12;
				}
				return {
					hour: String(hour12),
					minute: match24[2],
					meridiem: meridiem
				};
			}
			return {
				hour: String(hour24).padStart(2, "0"),
				minute: match24[2],
				meridiem: "AM"
			};
		}

		return {
			hour: mode.usesMeridiem ? "9" : "09",
			minute: "00",
			meridiem: "AM"
		};
	}

	function format_original_time_value(hourValue, minuteValue, meridiemValue, mode) {
		var hour24 = parseInt(hourValue, 10);
		if (mode.usesMeridiem) {
			if (meridiemValue === "PM" && hour24 < 12) {
				hour24 += 12;
			}
			if (meridiemValue === "AM" && hour24 === 12) {
				hour24 = 0;
			}
		}
		if (typeof format_php_datetime === "function") {
			return format_php_datetime({
				year: "2000",
				month: "01",
				day: "01",
				hour: String(hour24).padStart(2, "0"),
				minute: minuteValue
			}, mode.format);
		}
		if (mode.usesMeridiem) {
			var displayHour = mode.padHour ? String(hourValue).padStart(2, "0") : String(parseInt(hourValue, 10));
			var suffix = mode.uppercaseMeridiem ? meridiemValue.toUpperCase() : meridiemValue.toLowerCase();
			return displayHour + ":" + minuteValue + " " + suffix;
		}
		return String(hourValue).padStart(2, "0") + ":" + minuteValue;
	}

	function close_original_time_panel() {
		$(panelClass).remove();
		$(document).off("mousedown.ordersOriginalTime");
	}

	function open_original_time_panel() {
		close_original_time_panel();

		var current = originalTimeInput.val();
		var mode = get_original_time_picker_mode();
		var minuteStep = "10";
		var parsed = parse_original_time_value(current, mode);
		var hourValue = parsed.hour;
		var minuteValue = parsed.minute;
		var meridiemValue = parsed.meridiem;

		var hourOptions = "";
		var hourStart = mode.usesMeridiem ? 1 : 0;
		var hourEnd = mode.usesMeridiem ? 12 : 23;
		for (var h = hourStart; h <= hourEnd; h++) {
			var hh = mode.usesMeridiem ? String(h) : String(h).padStart(2, "0");
			hourOptions += '<option value="' + hh + '">' + hh + "</option>";
		}
		var meridiemSelectHtml = "";
		if (mode.usesMeridiem) {
			meridiemSelectHtml =
				'<div style="width:84px;">' +
					'<div style="font-size:12px;color:#64748b;margin-bottom:4px;">AM/PM</div>' +
					'<select class="orders-original-time-meridiem" style="width:100%;">' +
						'<option value="AM">AM</option>' +
						'<option value="PM">PM</option>' +
					'</select>' +
				'</div>';
		}
		var panel = $(
			'<div class="orders-original-time-panel" style="background:#fff;border:1px solid #cbd5e1;border-radius:10px;box-shadow:0 10px 30px rgba(15,23,42,0.18);padding:14px;min-width:260px;">' +
					'<div style="display:flex;justify-content:flex-end;align-items:center;margin-bottom:10px;font-size:12px;color:#475569;gap:8px;">' +
						'<label style="display:flex;align-items:center;gap:4px;cursor:pointer;"><input type="radio" name="orders_original_time_step" value="10" checked>10</label>' +
						'<label style="display:flex;align-items:center;gap:4px;cursor:pointer;"><input type="radio" name="orders_original_time_step" value="5">5</label>' +
					'<label style="display:flex;align-items:center;gap:4px;cursor:pointer;"><input type="radio" name="orders_original_time_step" value="1">1</label>' +
				'</div>' +
				'<div style="display:flex;gap:10px;align-items:end;margin-bottom:12px;">' +
					'<div style="flex:1;">' +
						'<div style="font-size:12px;color:#64748b;margin-bottom:4px;">' + get_client_localized_text("original_time_hour") + '</div>' +
						'<select class="orders-original-time-hour" style="width:100%;">' + hourOptions + '</select>' +
					'</div>' +
					'<div style="flex:1;">' +
						'<div style="font-size:12px;color:#64748b;margin-bottom:4px;">' + get_client_localized_text("original_time_minute") + '</div>' +
						'<select class="orders-original-time-minute" style="width:100%;"></select>' +
					'</div>' +
					meridiemSelectHtml +
				'</div>' +
				'<div style="display:flex;gap:8px;justify-content:flex-end;">' +
					'<button type="button" class="orders-original-time-clear">' + get_client_localized_text("original_time_clear") + '</button>' +
					'<button type="button" class="orders-original-time-set">' + get_client_localized_text("original_time_set") + '</button>' +
					'</div>' +
				'</div>'
			);

		$("body").append(panel);
		panel.css("width", Math.max(originalTimeInput.outerWidth(), 260));
		panel.find(".orders-original-time-hour").val(hourValue);
		panel.find(".orders-original-time-meridiem").val(meridiemValue);

		function rebuild_minute_options(step, selectedMinute) {
			var minuteOptions = "";
			for (var m = 0; m < 60; m += step) {
				var mm = String(m).padStart(2, "0");
				minuteOptions += '<option value="' + mm + '">' + mm + "</option>";
			}
			var minuteSelect = panel.find(".orders-original-time-minute");
			minuteSelect.html(minuteOptions);
			var normalizedMinute = String(Math.floor(parseInt(selectedMinute || "0", 10) / step) * step).padStart(2, "0");
			minuteSelect.val(normalizedMinute);
		}

		panel.find('input[name="orders_original_time_step"][value="' + minuteStep + '"]').prop("checked", true);
		rebuild_minute_options(parseInt(minuteStep, 10), minuteValue);

		panel.find('input[name="orders_original_time_step"]').on("change", function () {
			minuteStep = $(this).val();
			rebuild_minute_options(parseInt(minuteStep, 10), panel.find(".orders-original-time-minute").val());
		});

		setTimeout(function () {
			if (typeof reposition_fixed_panel_below_input === "function") {
				reposition_fixed_panel_below_input(panel, originalTimeInput.get(0));
			}
		}, 0);

		panel.find(".orders-original-time-clear").on("click", function () {
			originalTimeInput.val("").trigger("change");
			close_original_time_panel();
		});
		panel.find(".orders-original-time-set").on("click", function () {
			var selectedHour = panel.find(".orders-original-time-hour").val();
			var selectedMinute = panel.find(".orders-original-time-minute").val();
			var selectedMeridiem = panel.find(".orders-original-time-meridiem").val() || "AM";
			var value = format_original_time_value(selectedHour, selectedMinute, selectedMeridiem, mode);
			originalTimeInput.val(value).trigger("change");
			close_original_time_panel();
		});

		setTimeout(function () {
			$(document).on("mousedown.ordersOriginalTime", function (e) {
				if ($(e.target).closest(panelClass).length > 0) {
					return;
				}
				if ($(e.target).closest(".orders-original-time-input").length > 0) {
					return;
				}
				close_original_time_panel();
			});
		}, 0);
	}

	function toggle_fields() {
		var value = select.val();
		dateWrap.hide();
		timeWrap.hide();
		originalTimeWrap.hide();
		yearMonthWrap.hide();

		if (value === "date") {
			dateWrap.show();
		} else if (value === "time") {
			timeWrap.show();
		} else if (value === "original_time") {
			originalTimeWrap.show();
		} else if (value === "year_month") {
			yearMonthWrap.show();
		} else if (value === "all") {
			dateWrap.show();
			timeWrap.show();
			originalTimeWrap.show();
			yearMonthWrap.show();
		}
	}

	select.off("change.ordersPickerTest").on("change.ordersPickerTest", toggle_fields);
	originalTimeInput.off("click.ordersOriginalTime").on("click.ordersOriginalTime", function () {
		open_original_time_panel();
	});
	toggle_fields();
});
