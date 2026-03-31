<form id="wizard_note_edit_preview_form" onsubmit="return false;">
	<table style="width:100%;border-collapse:collapse;font-size:13px;margin-bottom:10px;">
		<tr>
			<th style="width:180px;text-align:left;border:1px solid #d5dbe5;background:#f4f7fb;padding:8px;">対象ノート</th>
			<td style="border:1px solid #d5dbe5;padding:8px;">{$row.target_tb_name|escape}</td>
		</tr>
		<tr>
			<th style="text-align:left;border:1px solid #d5dbe5;background:#f4f7fb;padding:8px;">ノート名</th>
			<td style="border:1px solid #d5dbe5;padding:8px;">{$row.menu_name|escape}</td>
		</tr>
		<tr>
			<th style="text-align:left;border:1px solid #d5dbe5;background:#f4f7fb;padding:8px;">説明</th>
			<td style="border:1px solid #d5dbe5;padding:8px;">{$row.description|escape|default:"-"}</td>
		</tr>
		<tr>
			<th style="text-align:left;border:1px solid #d5dbe5;background:#f4f7fb;padding:8px;">メニュー表示</th>
			<td style="border:1px solid #d5dbe5;padding:8px;">{$row.show_menu_label|escape}</td>
		</tr>
		<tr>
			<th style="text-align:left;border:1px solid #d5dbe5;background:#f4f7fb;padding:8px;">並び順の基準</th>
			<td style="border:1px solid #d5dbe5;padding:8px;">{$row.sortkey|escape}</td>
		</tr>
		<tr>
			<th style="text-align:left;border:1px solid #d5dbe5;background:#f4f7fb;padding:8px;">並び順</th>
			<td style="border:1px solid #d5dbe5;padding:8px;">{$row.sort_order_label|escape}</td>
		</tr>
		<tr>
			<th style="text-align:left;border:1px solid #d5dbe5;background:#f4f7fb;padding:8px;">一覧幅</th>
			<td style="border:1px solid #d5dbe5;padding:8px;">{$row.list_width|escape}px</td>
		</tr>
		<tr>
			<th style="text-align:left;border:1px solid #d5dbe5;background:#f4f7fb;padding:8px;">ダイアログ幅</th>
			<td style="border:1px solid #d5dbe5;padding:8px;">{$row.edit_width|escape}px</td>
		</tr>
	</table>

	<p style="font-size:12px;color:#4b5563;margin:0 0 12px 0;">Codex には db の対象レコード更新と影響確認を任せます。</p>

	<p style="font-weight:bold;margin:0 0 4px 0;">実行計画</p>
	<table style="width:100%;border-collapse:collapse;font-size:12px;">
		<tbody>
			{foreach $plan_lines as $line}
				<tr>
					<td style="width:56px;border:1px solid #d5dbe5;padding:6px;text-align:center;">{$line@iteration}</td>
					<td style="border:1px solid #d5dbe5;padding:6px;">{$line|escape}</td>
				</tr>
			{/foreach}
		</tbody>
	</table>

	<div style="margin-top:12px;overflow:auto;">
		<button type="button" class="ajax-link" invoke-function="back_to_note_edit_basic" style="float:left;">前へ</button>
		<button type="button" class="ajax-link" invoke-function="open_codex_terminal_with_prompt" style="float:right;">次へ</button>
	</div>
</form>
