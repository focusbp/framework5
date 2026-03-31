{if $testserver || $setting.show_developer_panel == 1}
	<div class="db_edit_button_area">
		<button class="ajax-link" invoke-class="db" invoke-function="edit" data-id="{$db_id}"  data-mode="screen" data-screen="add">
		<span class="material-symbols-outlined">table</span>
		</button>
	</div>
{/if}
