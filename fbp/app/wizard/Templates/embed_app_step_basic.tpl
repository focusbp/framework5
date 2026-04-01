<form id="wizard_embed_app_basic_form">
	<p style="font-size:13px;color:#374151;margin:0 0 8px 0;">{t key="wizard.embed_app.basic.description"}</p>

	<table style="width:100%;border-collapse:collapse;font-size:13px;">
		<tr>
			<th style="width:220px;text-align:left;border:1px solid #d5dbe5;background:#f4f7fb;padding:8px;">{t key="wizard.embed_app.basic.title"}</th>
			<td style="border:1px solid #d5dbe5;padding:8px;">
				<input type="text" name="title" value="{$row.title|default:''|escape}" style="width:100%;">
				<p class="error_message error_title"></p>
			</td>
		</tr>
	</table>

	<div style="margin-top:12px;overflow:auto;">
		<button type="button" class="ajax-link" invoke-function="back_to_embed_app_select" style="float:left;">{t key="common.back"}</button>
		<button type="button" class="ajax-link" invoke-function="submit_embed_app_basic_next" data-form="wizard_embed_app_basic_form" style="float:right;">{t key="common.next"}</button>
	</div>
</form>
