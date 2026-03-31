<div>
	<div style="float:right;margin-bottom:8px;">
		<button class="ajax-link" data-class="public_assets" data-function="add">Add Public Asset</button>
	</div>
	<p style="margin:0;color:#4b5563;font-size:12px;">public_pages で使う固定画像を管理します。実ファイルは classes/data/public_pages/assets/ に保存され、release に同梱されます。</p>
</div>
<div style="clear:both;"></div>

<table class="moredata" style="margin-top:10px;">
	<thead>
		<tr class="table-head">
			<th style="width:5%;"></th>
			<th style="width:12%;">Preview</th>
			<th style="width:20%;">Asset Key</th>
			<th style="width:24%;">Original Filename</th>
			<th style="width:21%;">Stored Filename</th>
			<th style="width:8%;">Status</th>
			<th style="width:10%;"></th>
		</tr>
	</thead>
	<tbody class="public-assets-sort">
		{foreach $items as $item}
			<tr id="{$item.id}" style="background:#FFF;">
				<td><span class="ui-icon ui-icon-arrowthick-2-n-s pa-handle"></span></td>
				<td>{if $item.preview_url != ''}<div style="width:90px;height:56px;border:1px solid #d1d5db;border-radius:4px;display:flex;align-items:center;justify-content:center;overflow:hidden;background:#000;"><img src="{$item.preview_url}" style="width:100%;height:100%;object-fit:contain;"></div>{/if}</td>
				<td><code style="display:inline;background:#111827;color:#fff;padding:4px 6px;border-radius:4px;font-size:10px;">{$item.asset_key|escape}</code></td>
				<td style="font-size:11px;word-break:break-all;">{$item.original_filename|escape}</td>
				<td style="font-size:11px;word-break:break-all;">{$item.stored_filename|escape}</td>
				<td>{if $item.enabled == 1}Show{else}Hide{/if}</td>
				<td>
					<button class="ajax-link listbutton" data-class="public_assets" data-function="delete" data-id="{$item.id}" style="float:right;color:black;margin-right:5px;"><span class="ui-icon ui-icon-trash"></span></button>
					<button class="ajax-link listbutton" data-class="public_assets" data-function="edit" data-id="{$item.id}" style="float:right;color:black;"><span class="ui-icon ui-icon-pencil"></span></button>
				</td>
			</tr>
		{/foreach}
	</tbody>
</table>

<script>
$(function () {
	$(".public-assets-sort").sortable({
		handle: ".pa-handle",
		axis: "y",
		update: function () {
			var log = $(this).sortable("toArray");
			var fd = new FormData();
			fd.append('class', 'public_assets');
			fd.append('function', 'sort');
			fd.append('log', log);
			appcon('app.php', fd);
		}
	});
});
</script>
