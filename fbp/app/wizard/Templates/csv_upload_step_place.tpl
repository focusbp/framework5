<form id="wizard_csv_upload_place_form">
	<p style="font-size:13px;color:#374151;margin:0 0 8px 0;">CSV Uploadボタンの配置場所を選択してください。</p>
	{if !$is_child}
		<p style="margin:0 0 6px 0;font-size:12px;color:#6b7280;">子テーブルではないため、子用の配置場所は表示していません。</p>
	{/if}
	<p style="font-weight:bold;margin:0 0 4px 0;">配置場所 *</p>
	{html_options name="place" options=$place_options selected=$row.place style="width:100%;"}
	<p class="error_message error_place"></p>

	<div style="margin-top:12px;overflow:auto;">
		<button type="button" class="ajax-link" invoke-function="back_to_csv_upload_table" style="float:left;">前へ</button>
		<button type="button" class="ajax-link" invoke-function="submit_csv_upload_place_next" data-form="wizard_csv_upload_place_form" style="float:right;">次へ</button>
	</div>
</form>
