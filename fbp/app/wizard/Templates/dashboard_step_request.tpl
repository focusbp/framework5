<form id="wizard_dashboard_request_form">
	<table class="moredata" style="margin-top:0px;margin-bottom:12px;">
		{if $row.title|default:'' neq ''}
			<tr><th style="width:30%;">Dashboard 名</th><td>{$row.title|escape}</td></tr>
		{/if}
		<tr><th style="width:30%;">Class Name</th><td><code style="display:inline;background:#111827;color:#fff;padding:4px 6px;border-radius:4px;font-size:10px;">{$row.class_name|escape}</code></td></tr>
		<tr><th>Function Name</th><td><code style="display:inline;background:#111827;color:#fff;padding:4px 6px;border-radius:4px;font-size:10px;">{$row.function_name|escape}</code></td></tr>
		<tr><th>Width</th><td>{$dashboard_column_width_label|escape}</td></tr>
	</table>

	{if $row.dashboard_action == 'edit'}
		<p style="font-size:13px;color:#374151;margin:0 0 8px 0;">変更したい内容を入力してください。既存の Dashboard ウィジェットを前提に、変更用の prompt を自動生成します。</p>
	{else}
		<p style="font-size:13px;color:#374151;margin:0 0 8px 0;">作りたい Dashboard の内容を入力してください。ウィジェット作成と dashboard 登録を前提に prompt を自動生成します。</p>
	{/if}
	<textarea name="request_text" style="width:100%;height:180px;">{$row.request_text|default:''|escape}</textarea>
	{if $row.dashboard_action == 'edit'}
		<p style="font-size:12px;color:#6b7280;margin:4px 0 0 0;">例: KPIカード表示に変更したい。グラフ種別を棒グラフから折れ線に変えたい。横幅を 2 column にしたい。</p>
	{else}
		<p style="font-size:12px;color:#6b7280;margin:4px 0 0 0;">例: 今月の売上件数を表示する KPI カードを追加したい。直近 6 か月の推移グラフを作りたい。</p>
	{/if}
	<p class="error_message error_request_text"></p>

	<div style="margin-top:12px;overflow:auto;">
		{if $row.dashboard_action == 'edit'}
			<button type="button" class="ajax-link" invoke-function="back_to_dashboard_target" style="float:left;">前へ</button>
		{else}
			<button type="button" class="ajax-link" invoke-function="back_to_dashboard_basic" style="float:left;">前へ</button>
		{/if}
		<button type="button" class="ajax-link" invoke-function="submit_dashboard_request_next" data-form="wizard_dashboard_request_form" style="float:right;">次へ</button>
	</div>
</form>
