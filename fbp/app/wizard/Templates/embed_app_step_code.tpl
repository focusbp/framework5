<div>
	<table style="width:100%;border-collapse:collapse;margin-bottom:12px;">
		<tbody>
			<tr><th style="width:180px;text-align:left;border:1px solid #d5dbe5;background:#f4f7fb;padding:8px;">{t key="wizard.embed_app.basic.title"}</th><td style="border:1px solid #d5dbe5;padding:8px;">{$row.title|escape}</td></tr>
			<tr><th style="text-align:left;border:1px solid #d5dbe5;background:#f4f7fb;padding:8px;">embed_key</th><td style="border:1px solid #d5dbe5;padding:8px;"><code style="display:inline;background:#111827;color:#fff;padding:4px 6px;border-radius:4px;font-size:10px;">{$row.embed_key|escape}</code></td></tr>
		</tbody>
	</table>

	<p style="font-size:13px;color:#374151;margin:0 0 8px 0;">{t key="wizard.embed_app.code.description"}</p>
	<textarea readonly id="wizard_embed_app_snippet_output" style="width:100%;height:260px;font-size:11px;">{$snippet_code nofilter}</textarea>

	<div style="margin-top:12px;overflow:auto;">
		<button type="button" class="ajax-link" invoke-function="back_to_embed_app_target" style="float:left;">{t key="common.back"}</button>
		<button type="button" class="wizard-embed-copy-btn" data-target="wizard_embed_app_snippet_output" style="float:right;">{t key="common.copy"}</button>
	</div>
</div>

{literal}
<script>
$(function () {
	$('.wizard-embed-copy-btn').off('click').on('click', function () {
		var targetId = $(this).data('target');
		var ta = document.getElementById(targetId);
		if (!ta) {
			return;
		}
		ta.focus();
		ta.select();
		document.execCommand('copy');
		$(this).text('{/literal}{t key="common.copied"|escape:'javascript'}{literal}');
		var btn = this;
		setTimeout(function () {
			$(btn).text('{/literal}{t key="common.copy"|escape:'javascript'}{literal}');
		}, 1200);
	});
});
</script>
{/literal}
