<form id="wizard_cron_start_form" onsubmit="return false;">
	<p style="font-size:13px;color:#374151;margin:0 0 10px 0;">{t key="wizard.cron.start.description"}</p>

	<table style="width:100%;border-collapse:collapse;font-size:13px;">
		<thead>
			<tr>
				<th style="width:60px;text-align:left;border:1px solid #d5dbe5;background:#f4f7fb;padding:8px;">ID</th>
				<th style="width:180px;text-align:left;border:1px solid #d5dbe5;background:#f4f7fb;padding:8px;">{t key="common.title"}</th>
				<th style="text-align:left;border:1px solid #d5dbe5;background:#f4f7fb;padding:8px;">Class / Function</th>
				<th style="width:240px;text-align:left;border:1px solid #d5dbe5;background:#f4f7fb;padding:8px;">{t key="wizard.cron.timing.label"}</th>
			</tr>
		</thead>
		<tbody>
			{foreach $cron_rows as $one}
				<tr>
					<td style="border:1px solid #d5dbe5;padding:8px;">{$one.id|escape}</td>
					<td style="border:1px solid #d5dbe5;padding:8px;">{$one.title|escape|default:"-"}</td>
					<td style="border:1px solid #d5dbe5;padding:8px;">{$one.class_name|escape}::{$one.function_name|escape}</td>
					<td style="border:1px solid #d5dbe5;padding:8px;">{$one.timing_text|escape}</td>
				</tr>
			{foreachelse}
				<tr>
					<td colspan="4" style="border:1px solid #d5dbe5;padding:8px;">{t key="wizard.cron.start.empty"}</td>
				</tr>
			{/foreach}
		</tbody>
	</table>

	<div style="margin-top:12px;overflow:auto;">
		<button type="button" class="ajax-link" invoke-function="back_to_cron_select" style="float:left;">{t key="common.back"}</button>
		<button type="button" class="ajax-link" invoke-function="submit_cron_start_exe" style="float:right;">{t key="wizard.cron.start.button"}</button>
	</div>
</form>
