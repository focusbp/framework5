<form id="wizard_step_menu_form">
	<p style="font-size:13px;color:#374151;margin:0 0 8px 0;">左メニュー表示名です。用途に沿ったわかりやすい名称にしてください。</p>
	<p style="font-weight:bold;margin:0 0 4px 0;">メニュー名 *</p>
	<input type="text" name="menu_name" value="{$row.menu_name|escape}" style="width:100%;" />
	<p class="error_message error_menu_name"></p>
	<div style="margin-top:12px;overflow:auto;">
		<button type="button" class="ajax-link" invoke-function="back_to_table" style="float:left;">前へ</button>
		<button type="button" class="ajax-link" invoke-function="submit_menu_next" data-form="wizard_step_menu_form" style="float:right;">次へ</button>
	</div>
</form>
