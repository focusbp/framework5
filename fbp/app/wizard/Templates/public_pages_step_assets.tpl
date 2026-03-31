<form id="wizard_public_pages_assets_form">
	<input type="hidden" name="page_action" value="{$row.page_action|escape}">
	{if $row.page_action == 'common_design'}
		<p style="font-size:13px;color:#374151;margin:0 0 8px 0;">共通デザインで使う画像を選択してください。要件入力は次の画面で行います。</p>
	{elseif $row.page_action == 'edit'}
		<table class="moredata" style="margin-top:0px;margin-bottom:12px;">
			<tr><th style="width:30%;">ページタイトル</th><td>{$row.title|escape}</td></tr>
		</table>
		<p style="font-size:13px;color:#374151;margin:0 0 8px 0;">変更で使う画像を選択してください。要件入力は次の画面で行います。</p>
	{else}
		<table class="moredata" style="margin-top:0px;margin-bottom:12px;">
			<tr><th style="width:30%;">ページタイトル</th><td>{$row.title|escape}</td></tr>
		</table>
		<p style="font-size:13px;color:#374151;margin:0 0 8px 0;">この公開ページで使う画像を選択してください。要件入力は次の画面で行います。</p>
	{/if}

	{if count($public_asset_rows) > 0}
		<table class="moredata" style="margin-top:0px;">
			<thead>
				<tr class="table-head">
					<th style="width:8%;"></th>
					<th style="width:16%;">Preview</th>
					<th style="width:36%;">Asset Key</th>
					<th style="width:40%;">Original Filename</th>
				</tr>
			</thead>
			<tbody>
				{foreach $public_asset_rows as $asset}
					<tr>
						<td style="text-align:center;"><input type="checkbox" name="public_asset_ids[]" value="{$asset.id}" {if $asset.selected == 1}checked{/if}></td>
						<td>{if $asset.preview_url != ''}<div style="width:90px;height:56px;border:1px solid #d1d5db;border-radius:4px;display:flex;align-items:center;justify-content:center;overflow:hidden;background:#000;"><img src="{$asset.preview_url}" style="width:100%;height:100%;object-fit:contain;"></div>{/if}</td>
						<td><code style="display:inline;background:#111827;color:#fff;padding:4px 6px;border-radius:4px;font-size:10px;">{$asset.asset_key|escape}</code></td>
						<td style="font-size:11px;word-break:break-all;">{$asset.original_filename|escape}</td>
					</tr>
				{/foreach}
			</tbody>
		</table>
	{else}
		<p style="font-size:13px;color:#6b7280;margin:0;">登録済みの画像はありません。必要なら「画像の登録」で先に追加してください。</p>
	{/if}

	<div style="margin-top:12px;overflow:auto;">
		{if $row.page_action == 'common_design'}
			<button type="button" class="ajax-link" invoke-function="back_to_public_pages_select" style="float:left;">前へ</button>
		{elseif $row.page_action == 'edit'}
			<button type="button" class="ajax-link" invoke-function="back_to_public_pages_target" style="float:left;">前へ</button>
		{else}
			<button type="button" class="ajax-link" invoke-function="back_to_public_pages_add_info" style="float:left;">前へ</button>
		{/if}
		<button type="button" class="ajax-link" invoke-function="submit_public_pages_assets_next" data-form="wizard_public_pages_assets_form" style="float:right;">次へ</button>
	</div>
</form>
