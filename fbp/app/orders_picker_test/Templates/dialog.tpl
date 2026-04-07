<form onsubmit="return false;" id="orders_picker_test_form">
	<p style="margin:0 0 12px 0;color:#475569;">{t key="orders_picker_test.description"}</p>

	<div style="margin-bottom:14px;">
		<p style="font-weight:bold;margin:0 0 6px 0;">{t key="orders_picker_test.target"}</p>
		<select name="picker_target" id="orders_picker_target">
			<option value=""></option>
			<option value="date">Datepicker</option>
			<option value="time">Timepicker</option>
			<option value="year_month">Year Month Picker</option>
			<option value="dropdown">{t key="orders_picker_test.large_dropdown"}</option>
			<option value="all">{t key="orders_picker_test.show_all"}</option>
		</select>
	</div>

	<div class="orders_picker_test_field orders_picker_test_date" style="display:none;margin-bottom:14px;">
		<p style="font-weight:bold;margin:0 0 6px 0;">Datepicker</p>
		<input type="text" name="test_date" class="datepicker" placeholder="日付を選択">
	</div>

	<div class="orders_picker_test_field orders_picker_test_time" style="display:none;margin-bottom:14px;">
		<p style="font-weight:bold;margin:0 0 6px 0;">Timepicker</p>
		<input type="text" name="test_time" class="timepicker" placeholder="時間を選択">
	</div>

	<div class="orders_picker_test_field orders_picker_test_year_month" style="display:none;margin-bottom:14px;">
		<p style="font-weight:bold;margin:0 0 6px 0;">Year Month Picker</p>
		<input type="text" name="test_year_month" class="year_month_picker" placeholder="年月を選択">
	</div>

	<div class="orders_picker_test_field orders_picker_test_dropdown" style="display:none;margin-bottom:14px;">
		<p style="font-weight:bold;margin:0 0 6px 0;">{t key="orders_picker_test.large_dropdown"}</p>
		<p style="margin:0 0 8px 0;color:#64748b;font-size:12px;">{t key="orders_picker_test.large_dropdown_description"}</p>
		<select name="test_large_dropdown" class="orders_picker_test_large_dropdown" style="width:100%;">
			<option value="">{t key="orders_picker_test.unselected"}</option>
			<option value="tokyo">Tokyo</option>
			<option value="osaka">Osaka</option>
			<option value="nagoya">Nagoya</option>
			<option value="sapporo">Sapporo</option>
			<option value="fukuoka">Fukuoka</option>
			<option value="sendai">Sendai</option>
			<option value="hiroshima">Hiroshima</option>
			<option value="kobe">Kobe</option>
			<option value="kyoto">Kyoto</option>
			<option value="yokohama">Yokohama</option>
			<option value="naha">Naha</option>
			<option value="kanazawa">Kanazawa</option>
			<option value="kumamoto">Kumamoto</option>
			<option value="niigata">Niigata</option>
			<option value="kagoshima">Kagoshima</option>
		</select>
	</div>

	<div style="display:flex;justify-content:flex-end;">
		<button type="button" class="ajax-link" invoke-function="close_dialog">{t key="common.close"}</button>
	</div>
</form>
