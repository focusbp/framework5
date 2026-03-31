<div id="wizard_line_member_link_template_area">
	<p style="font-size:13px;color:#374151;margin:0 0 8px 0;">LINE用会員DBは固定テンプレートで作成します。次へでそのまま Codex Terminal にプロンプトを投入します。</p>
	<table style="width:100%;border-collapse:collapse;font-size:13px;margin-bottom:8px;">
		<tr>
			<th style="width:220px;text-align:left;border:1px solid #d5dbe5;background:#f4f7fb;padding:8px;">テーブル名</th>
			<td style="border:1px solid #d5dbe5;padding:8px;">{$row.tb_name|escape}</td>
		</tr>
		<tr>
			<th style="text-align:left;border:1px solid #d5dbe5;background:#f4f7fb;padding:8px;">LINE user_id</th>
			<td style="border:1px solid #d5dbe5;padding:8px;">{$row.user_id_field|escape}</td>
		</tr>
		<tr>
			<th style="text-align:left;border:1px solid #d5dbe5;background:#f4f7fb;padding:8px;">表示名</th>
			<td style="border:1px solid #d5dbe5;padding:8px;">{$row.display_name_field|escape}</td>
		</tr>
		<tr>
			<th style="text-align:left;border:1px solid #d5dbe5;background:#f4f7fb;padding:8px;">名前</th>
			<td style="border:1px solid #d5dbe5;padding:8px;">{$row.name_field|escape}</td>
		</tr>
		<tr>
			<th style="text-align:left;border:1px solid #d5dbe5;background:#f4f7fb;padding:8px;">作成内容</th>
			<td style="border:1px solid #d5dbe5;padding:8px;">会員DB + getting_member + 未登録時の新規作成</td>
		</tr>
	</table>
	<p class="error_message error_line_member_template"></p>

	<div style="margin-top:12px;overflow:auto;">
		<button type="button" class="ajax-link" invoke-function="back_to_line_bot_select" style="float:left;">前へ</button>
		<button type="button" class="ajax-link" invoke-function="submit_line_member_link_table_next" style="float:right;">次へ</button>
	</div>
</div>
