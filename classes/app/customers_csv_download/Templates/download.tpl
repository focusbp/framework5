<form id="customers_csv_download_form">
	<p style="margin:10px 0 8px;">顧客{$count}件をCSVで出力します。</p>
	<div style="margin:0 0 12px;">
		<label style="display:block;margin:0 0 4px;">文字コード</label>
		<select name="encode" style="width:220px;">
			<option value="UTF-8">UTF-8</option>
			<option value="sjis-win">Shift_JIS</option>
		</select>
	</div>
	<button class="btn btn-primary download-link" data-class="customers_csv_download" data-function="csv_download" data-filename="customers.csv" data-form="customers_csv_download_form">CSV Download</button>
</form>
