<form id="wizard_step_project_form">
	<p style="font-size:13px;color:#374151;margin:0 0 8px 0;">用途から推測した候補を入れています。必要なら修正してください。</p>
	<p style="font-weight:bold;margin:0 0 4px 0;">対象プロジェクト *</p>
	<input type="text" name="project_name" value="{$row.project_name|escape}" style="width:100%;" />
	<p class="error_message error_project_name"></p>
	<div style="display:flex;gap:8px;margin-top:12px;">
		<button type="button" class="ajax-link" invoke-function="submit_project_next" data-form="wizard_step_project_form">次へ</button>
		<button type="button" class="ajax-link" invoke-function="back_to_purpose">前へ</button>
		<button type="button" class="ajax-link" invoke-function="close_dialog">閉じる</button>
	</div>
</form>
