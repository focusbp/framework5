<form id="wizard_public_pages_asset_add_form" onsubmit="return false;">
	<p style="font-size:13px;color:#374151;margin:0 0 8px 0;">public_pages で使う画像を登録します。Status は Show 固定です。</p>
	<table class="custom_events_table">
		<tbody>
			<tr>
				<td style="width:30%;">Image File</td>
				<td>
					<input type="file" name="asset_file" accept="image/*">
					<p style="font-size:12px;color:#6b7280;margin:4px 0 0 0;">Asset Key はランダム文字列で自動設定します。</p>
					<p class="error_message error_asset_file"></p>
				</td>
			</tr>
		</tbody>
	</table>
	<div style="margin-top:12px;overflow:auto;">
		<button type="button" class="ajax-link" invoke-function="back_to_public_pages_select" style="float:left;">前へ</button>
		<button type="button" class="ajax-link" invoke-function="submit_public_pages_asset_add_exe" data-form="wizard_public_pages_asset_add_form" style="float:right;">登録</button>
	</div>
</form>
