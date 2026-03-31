<form id="wizard_public_pages_common_confirm_form">
	{if count($selected_public_asset_rows) > 0}
		<p style="font-weight:bold;margin:0 0 6px 0;">使用するPublic Assets</p>
		<table class="moredata" style="margin-top:0px;margin-bottom:12px;">
			<thead>
				<tr class="table-head">
					<th style="width:16%;">Preview</th>
					<th style="width:36%;">Asset Key</th>
					<th style="width:40%;">Original Filename</th>
				</tr>
			</thead>
			<tbody>
				{foreach $selected_public_asset_rows as $asset}
					<tr>
						<td>{if $asset.preview_url != ''}<div style="width:90px;height:56px;border:1px solid #d1d5db;border-radius:4px;display:flex;align-items:center;justify-content:center;overflow:hidden;background:#000;"><img src="{$asset.preview_url}" style="width:100%;height:100%;object-fit:contain;"></div>{/if}</td>
						<td><code style="display:inline;background:#111827;color:#fff;padding:4px 6px;border-radius:4px;font-size:10px;">{$asset.asset_key|escape}</code></td>
						<td style="font-size:11px;word-break:break-all;">{$asset.original_filename|escape}</td>
					</tr>
				{/foreach}
			</tbody>
		</table>
	{/if}

	<table class="moredata" style="margin-top:0px;">
		<tr><th style="width:30%;">ヘッダ要件</th><td>{$row.common_header_text|escape|nl2br}</td></tr>
		<tr><th>フッタ要件</th><td>{$row.common_footer_text|escape|nl2br}</td></tr>
		<tr><th>共通導線</th><td>{$row.common_nav_text|escape|nl2br}</td></tr>
		<tr><th>デザイン方針</th><td>{$row.common_style_text|escape|nl2br}</td></tr>
	</table>

	<div style="margin-top:12px;overflow:auto;">
		<button type="button" class="ajax-link" invoke-function="back_to_public_pages_common_style" style="float:left;">前へ</button>
		<button type="button" class="ajax-link" invoke-function="submit_public_pages_common_confirm_next" style="float:right;">次へ</button>
	</div>
</form>
