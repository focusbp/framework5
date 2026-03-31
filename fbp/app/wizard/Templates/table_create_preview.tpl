<form id="wizard_table_create_preview_form" onsubmit="return false;">
	<input type="hidden" name="purpose" value="{$row.purpose|escape}" />
	<input type="hidden" name="note_title" value="{$row.note_title|escape}" />
	<input type="hidden" name="field_mode" value="{$row.field_mode|escape}" />
	<input type="hidden" name="manual_fields_text" value="{$row.manual_fields_text|escape}" />

	<table style="width:100%;border-collapse:collapse;font-size:13px;margin-bottom:10px;">
		<tr>
			<th style="width:180px;text-align:left;border:1px solid #d5dbe5;background:#f4f7fb;padding:8px;">用途</th>
			<td style="border:1px solid #d5dbe5;padding:8px;">{$row.purpose|escape}</td>
		</tr>
		{if $row.create_mode == "child"}
		<tr>
			<th style="text-align:left;border:1px solid #d5dbe5;background:#f4f7fb;padding:8px;">親ノート</th>
			<td style="border:1px solid #d5dbe5;padding:8px;">{$row.parent_tb_name|escape} ({$row.parent_menu_name|escape})</td>
		</tr>
		{/if}
		<tr>
			<th style="text-align:left;border:1px solid #d5dbe5;background:#f4f7fb;padding:8px;">ノート名</th>
			<td style="border:1px solid #d5dbe5;padding:8px;">{$row.note_title|escape}</td>
		</tr>
		<tr>
			<th style="text-align:left;border:1px solid #d5dbe5;background:#f4f7fb;padding:8px;">項目設定方法</th>
			<td style="border:1px solid #d5dbe5;padding:8px;">{$row.field_mode_label|escape}</td>
		</tr>
		<tr>
			<th style="text-align:left;border:1px solid #d5dbe5;background:#f4f7fb;padding:8px;">項目指定</th>
			<td style="border:1px solid #d5dbe5;padding:8px;white-space:pre-wrap;line-height:1.7;">{if $row.field_mode == "manual"}{$row.manual_fields_text|escape}{else}用途からCodexが自動提案{/if}</td>
		</tr>
	</table>

	<p style="font-size:12px;color:#4b5563;margin:0 0 12px 0;">Codexには db名決定 / db追加 / db_fields追加 / screen_fields設定 を任せます。</p>

	<p style="font-weight:bold;margin:0 0 4px 0;">実行計画</p>
	<table style="width:100%;border-collapse:collapse;font-size:12px;">
		<thead>
			<tr>
				<th style="width:56px;border:1px solid #d5dbe5;background:#f4f7fb;padding:6px;">No</th>
				<th style="border:1px solid #d5dbe5;background:#f4f7fb;padding:6px;text-align:left;">内容</th>
			</tr>
		</thead>
		<tbody>
			{foreach $plan_lines as $line}
				<tr>
					<td style="border:1px solid #d5dbe5;padding:6px;text-align:center;">{$line@iteration}</td>
					<td style="border:1px solid #d5dbe5;padding:6px;">{$line|escape}</td>
				</tr>
			{/foreach}
		</tbody>
	</table>

	<div style="margin-top:12px;overflow:auto;">
		<button type="button" class="ajax-link" invoke-function="back_to_fields" style="float:left;">前へ</button>
		<button type="button" class="ajax-link" invoke-function="open_codex_terminal_with_prompt" style="float:right;">次へ</button>
	</div>
</form>
