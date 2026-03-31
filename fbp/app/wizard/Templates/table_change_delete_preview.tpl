<form id="wizard_table_change_delete_preview_form">
	<table style="width:100%;border-collapse:collapse;font-size:13px;margin-bottom:10px;">
		<tr>
			<th style="width:180px;text-align:left;border:1px solid #d5dbe5;background:#f4f7fb;padding:8px;">変更種別</th>
			<td style="border:1px solid #d5dbe5;padding:8px;">項目の削除</td>
		</tr>
		<tr>
			<th style="text-align:left;border:1px solid #d5dbe5;background:#f4f7fb;padding:8px;">対象テーブル</th>
			<td style="border:1px solid #d5dbe5;padding:8px;">{$row.target_tb_name|escape}</td>
		</tr>
		<tr>
			<th style="text-align:left;border:1px solid #d5dbe5;background:#f4f7fb;padding:8px;">削除項目</th>
			<td style="border:1px solid #d5dbe5;padding:8px;white-space:pre-wrap;line-height:1.7;">{$row.fields_text|escape}</td>
		</tr>
	</table>

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
		<button type="button" class="ajax-link" invoke-function="back_to_table_change_delete_fields" style="float:left;">前へ</button>
		<button type="button" class="ajax-link" invoke-function="open_codex_terminal_with_prompt" style="float:right;">次へ</button>
	</div>
</form>
