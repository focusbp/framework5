<form id="wizard_step_purpose_form" onsubmit="return false;">
	<p style="font-size:13px;color:#374151;margin:0 0 8px 0;">どんな管理をしたいかを1つ入力してください。次画面でノート名を決め、その後に項目設定方法を選びます。</p>
	{if $row.create_mode == "child"}
		<p style="font-size:12px;color:#6b7280;margin:0 0 8px 0;">親ノート: {$row.parent_tb_name|escape} ({$row.parent_menu_name|escape})</p>
	{/if}
	<p style="font-weight:bold;margin:0 0 4px 0;">用途 *</p>
	<textarea name="purpose" rows="4" style="width:100%;" placeholder="例: 問い合わせ受付情報を管理したい">{$row.purpose|escape}</textarea>
	<p class="error_message error_purpose"></p>
	<div style="margin-top:12px;overflow:auto;">
		<button type="button" class="ajax-link" invoke-function="{$back_function|default:'run'|escape}" style="float:left;">前へ</button>
		<button type="button" class="ajax-link" invoke-function="submit_purpose_next" data-form="wizard_step_purpose_form" style="float:right;">次へ</button>
	</div>
</form>
