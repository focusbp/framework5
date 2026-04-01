<p style="font-size:13px;color:#374151;margin:0 0 8px 0;">{t key="wizard.db_additionals.sort_list.description"}</p>
<p style="margin:0 0 12px 0;font-size:13px;">{$row.tb_name|escape} / {$db_additionals_place_label|escape}</p>

<style>
#wizard_button_sort .sort_button {
	border: 1px #ccc solid;
	display: block;
	width: 100%;
	padding: 5px 10px;
	border-radius: 5px;
	float: right;
	background: #FFF;
	margin-bottom: 10px;
	box-sizing: border-box;
	cursor: move;
}
</style>

{if $additionals|@count > 0}
<div id="wizard_button_sort">
	{foreach $additionals as $a}
		<div class="ajax-link lang sort_button" id="{$a.id}" data-class="{$a.class_name}" data-function="{$a.function_name}">{$a.button_title}</div>
	{/foreach}
</div>
{else}
<p style="margin:0 0 12px 0;color:#64748b;">{t key="wizard.db_additionals.sort_list.empty"}</p>
{/if}

<div style="margin-top:12px;overflow:auto;">
	<button type="button" class="ajax-link" invoke-function="back_to_db_additionals_sort_place" style="float:left;">{t key="common.back"}</button>
	<button type="button" class="ajax-link" invoke-function="submit_db_additionals_sort_finish" style="float:right;">{t key="wizard.db_additionals.sort.complete"}</button>
</div>

<script>
{literal}
if (typeof $ !== "undefined" && $("#wizard_button_sort").length > 0) {
	$("#wizard_button_sort").sortable({
		axis: "y",
		distance: 0,
		delay: 0,
		tolerance: "pointer",
		helper: "clone",
		update: function () {
			var log = $(this).sortable("toArray");
			var fd = new FormData();
			fd.append("class", "db_additionals");
			fd.append("function", "button_sort_exe");
			fd.append("place", "{/literal}{$row.place|escape}{literal}");
			fd.append("log", log);
			appcon("app.php", fd);
		}
	});
}
{/literal}
</script>