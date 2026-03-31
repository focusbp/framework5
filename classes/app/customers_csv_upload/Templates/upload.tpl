<form id="customers_csv_upload_form">
	<p style="margin:10px 0 8px;">顧客{$count}件の環境にCSVを追加登録します。</p>
	<p style="margin:0 0 12px;">ヘッダ行は `contact_name_kana` / `email` / `phone` または各日本語タイトルを使用してください。</p>

	{fields_form_original name="csv_file" type="file" title="CSVファイル"}

	<div style="margin:12px 0;">
		<label style="display:block;margin:0 0 4px;">文字コード</label>
		<select name="encode" style="width:220px;">
			<option value="UTF-8">UTF-8</option>
			<option value="sjis-win">Shift_JIS</option>
		</select>
	</div>

	<button type="button" class="btn btn-primary ajax-link" invoke-function="upload_exe" data-form="customers_csv_upload_form">アップロード</button>
</form>
