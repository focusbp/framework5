<form id="wizard_embed_app_target_form">
	{if $row.embed_action == 'delete'}
		<p style="font-size:13px;color:#374151;margin:0 0 8px 0;">削除する Embed App を選択してください。次へで Codex Terminal に削除プロンプトを投入します。</p>
	{else}
		<p style="font-size:13px;color:#374151;margin:0 0 8px 0;">変更する Embed App を選択してください。</p>
	{/if}
	<p style="font-weight:bold;margin:0 0 4px 0;">対象 Embed App *</p>
	{html_options name="embed_app_id" options=$embed_app_options selected=$row.embed_app_id style="width:100%;"}
	<p class="error_message error_embed_app_id"></p>

	<div style="margin-top:12px;overflow:auto;">
		<button type="button" class="ajax-link" invoke-function="back_to_embed_app_select" style="float:left;">前へ</button>
		<button type="button" class="ajax-link" invoke-function="submit_embed_app_target_next" data-form="wizard_embed_app_target_form" style="float:right;">次へ</button>
	</div>
</form>
