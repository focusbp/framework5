<form id="wizard_public_pages_add_info_form">
	<p style="font-size:13px;color:#374151;margin:0 0 8px 0;">公開ページの基本情報を入力してください。</p>
	<p style="font-weight:bold;margin:0 0 4px 0;">ページタイトル *</p>
	<input type="text" name="title" value="{$row.title|default:''|escape}" style="width:100%;">
	<p class="error_message error_title"></p>
	<p style="font-size:12px;color:#6b7280;margin:8px 0 0 0;">function名はページタイトルから自動作成します。</p>

	<div style="margin-top:12px;overflow:auto;">
		<button type="button" class="ajax-link" invoke-function="back_to_public_pages_select" style="float:left;">前へ</button>
		<button type="button" class="ajax-link" invoke-function="submit_public_pages_add_info_next" data-form="wizard_public_pages_add_info_form" style="float:right;">次へ</button>
	</div>
</form>
