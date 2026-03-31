	<div class="unassigned_tasks calendar_box" style="min-height:100vh">
		{foreach $unassigned as $row}
			{include file="_row_for_weekly.tpl"}
		{/foreach}
	</div>
