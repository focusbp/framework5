<div>
	<p style="margin:0 0 8px 0;font-size:14px;font-weight:bold;color:#111827;">標準画面設定を更新しました。</p>
	<p style="margin:0 0 12px 0;font-size:13px;color:#374151;">続けて画面全体を更新してください。</p>
	<table style="width:100%;border-collapse:collapse;font-size:13px;margin-bottom:12px;">
		<tr>
			<th style="width:180px;text-align:left;border:1px solid #d5dbe5;background:#f4f7fb;padding:8px;">対象テーブル</th>
			<td style="border:1px solid #d5dbe5;padding:8px;">{$row.target_tb_name|escape}</td>
		</tr>
	</table>
	<div style="overflow:auto;">
		<button type="button" class="ajax-link" invoke-function="run" style="float:left;">一覧へ戻る</button>
		<button type="button" class="ajax-link" invoke-function="reflesh_all_screen" style="float:right;">Reflesh All Screen</button>
	</div>
</div>
