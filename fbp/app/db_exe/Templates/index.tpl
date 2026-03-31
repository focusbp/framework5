{if $testserver || $setting.show_developer_panel == 1}
	<div class="db_edit_button_area">
		<button class="ajax-link" invoke-class="db" invoke-function="edit" data-id="{$db_id}" data-mode="database">
			<span class="material-symbols-outlined">database</span>
		</button>
	</div>
{/if}

<div class="db_exe_page_context" data-db-id="{$db_id}" data-tb-name="{$tb_name|escape}" data-class="{$class|escape}">
	<div style="float:right;margin-bottom: 8px;">

		{if $flg_add_button}
			<button class="ajax-link lang" data-class="{$class}" data-function="add" data-db_id="{$db_id}">Add</button>
		{else}
			{if $testserver || $setting.show_developer_panel == 1}
				<div class="db_edit_button_area" style="float:right;">
					<button class="ajax-link" invoke-class="db" invoke-function="edit" data-id="{$db_id}"  data-mode="screen" data-screen="add">
						<span class="material-symbols-outlined">table</span>
					</button>
				</div>
			{/if}
		{/if}

		{foreach $additionals as $a}
			{if $a.button_type == 0}
			<button class="ajax-link lang {$a.show_button_class}" data-class="{$a.class_name}" data-function="{$a.function_name}">{$a.button_title}</button>
			{else}
				<button class="ajax-link lang {$a.show_button_class}" data-class="{$a.class_name}" data-function="{$a.function_name}" style="padding:6px;"><span class="material-symbols-outlined">{$a.button_title}</span></button>
			{/if}
			
			{if $testserver || $setting.show_developer_panel == 1}
			{if $a.class_name != "admin"}
				<a style="float:right;margin-left:5px;margin-right:-10px;" class="ajax-link" invoke-class="db_additionals" invoke-function="edit" data-id="{$a.id}" data-reload_db_id="{$db_id}"><span class="material-symbols-outlined">smart_toy</span></a>
			{/if}
			{/if}
		{/foreach}

		{if $testserver || $setting.show_developer_panel == 1}
			<a style="float:right;margin-left:5px;margin-right:0px;" class="ajax-link" invoke-class="db_additionals" invoke-function="add" data-id="{$db_id}"><span class="material-symbols-outlined">library_add</span></a>
			<a style="float:right;margin-left:5px;margin-right:0px;" class="ajax-link" invoke-class="db_additionals" invoke-function="button_sort" data-tb_name="{$a.tb_name}" data-place="{$a.place}"><span class="material-symbols-outlined">overview_key</span></a>
		{/if}

	</div>
</div>
<div style="clear:both;"></div>

{if $show_search_box || $testserver}

	{if $testserver || $setting.show_developer_panel == 1}
		<div class="db_edit_button_area">
			<button class="ajax-link" invoke-class="db" invoke-function="edit" data-id="{$db_id}" data-mode="screen" data-screen="search">
				<span class="material-symbols-outlined">table</span>
			</button>
		</div>
	{/if}

	<div class="search_box" data-db-id="{$db_id}" data-tb-name="{$tb_name|escape}">
		{if $show_search_box }
		<div class="search_left">
			<form id="form_{$timestamp}" class="search_form_flex" data-db-id="{$db_id}" data-tb-name="{$tb_name|escape}">
				<input type="hidden" name="db_id" value="{$db_id}">
				{foreach $group1 as $field}
					<div class="search_form_item" data-parameter-name="{$field.parameter_name|escape}" data-parameter-title="{$field.parameter_title|escape}" data-field-type="{$field.type|escape}">
						{include file="{$base_template_dir}/__item_search.tpl"}
						<p class="error_message error_{$field["parameter_name"]}" style="margin-top:0px;"></p>
						{assign var="search_field_list" value=$search_field_list|cat:$field.parameter_name}
						{assign var="search_field_list" value=$search_field_list|cat:","}
					</div>
				{/foreach}
				<input type="hidden" name="_search_field_list" value="{$search_field_list}">
			</form>
		</div>
		
			<div class="search_right" style="display:none;">
				<button class="ajax-link lang" data-class="{$class}" data-function="search" data-form="form_{$timestamp}" data-db-id="{$db_id}" data-tb-name="{$tb_name|escape}">Search</button>
			</div>
		{else}
			<p class="lang" style="color:#4ba3ff;margin-left:10px;">No search fields are configured</p>
		{/if}
	</div>
{/if}

{if $testserver || $setting.show_developer_panel == 1}
	<div class="db_edit_button_area">
		<button class="ajax-link" invoke-class="db" invoke-function="edit" data-id="{$db_id}"  data-mode="screen" data-screen="list">
			<span class="material-symbols-outlined">table</span>
		</button>
	</div>
{/if}

<div id="main_table">
</div>
