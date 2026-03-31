<h6 style="margin-top:10px;">{$table_title}</h6>
{if $testserver || $setting.show_developer_panel == 1}
	<div class="db_edit_button_area">
		<button class="ajax-link" invoke-class="db" invoke-function="edit" data-id="{$db_id}" data-mode="database">
		<span class="material-symbols-outlined">database</span>
		</button>
	</div>
{/if}

		{if $flg_add_button}
			<button class="ajax-link lang" data-class="{$class}" data-function="add_child" data-db_id="{$db_id}" data-parent_id={$parent_id}>Add</button>
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
			<button class="ajax-link lang {$a.show_button_class}" data-class="{$a.class_name}" data-function="{$a.function_name}" data-parent_id="{$parent_id}">{$a.button_title}</button>
			{else}
				<button class="ajax-link lang {$a.show_button_class}" data-class="{$a.class_name}" data-function="{$a.function_name}" data-parent_id="{$parent_id}" style="padding:6px;"><span class="material-symbols-outlined">{$a.button_title}</span></button>
			{/if}
			{if $testserver || $setting.show_developer_panel == 1}
			{if $a.class_name != "admin"}
				<a style="float:right;margin-left:5px;margin-right:-10px;" class="ajax-link" invoke-class="db_additionals" invoke-function="edit" data-id="{$a.id}" data-reload_db_id="{$db_id}"><span class="material-symbols-outlined">smart_toy</span></a>
			{/if}
			{/if}
		{/foreach}
		
		{if $testserver || $setting.show_developer_panel == 1}
			<a style="float:right;margin-left:5px;margin-right:0px;" class="ajax-link" invoke-class="db_additionals" invoke-function="add" data-id="{$db_id}" data-place="2"><span class="material-symbols-outlined">library_add</span></a>
			<a style="float:right;margin-left:5px;margin-right:0px;" class="ajax-link" invoke-class="db_additionals" invoke-function="button_sort" data-tb_name="{$tb_name}" data-place="2"><span class="material-symbols-outlined">overview_key</span></a>
		{/if}

<div style="clear:both;"></div>

{if $testserver || $setting.show_developer_panel == 1}
	<div class="db_edit_button_area">
		<button class="ajax-link" invoke-class="db" invoke-function="edit" data-id="{$db_id}" data-mode="screen" data-screen="search">
			<span class="material-symbols-outlined">table</span>
		</button>
	</div>
{/if}

{if $show_search_box || $testserver}
	<div class="search_box" data-db-id="{$db_id}" data-tb-name="{$tb_name|escape}">
		{if $show_search_box}
		<div class="search_left">
			<form id="form_side_{$timestamp}" class="search_form_flex" data-db-id="{$db_id}" data-tb-name="{$tb_name|escape}">
				<input type="hidden" name="db_id" value="{$db_id}">
				<input type="hidden" name="parent_id" value="{$parent_id}">
				{foreach $search_group as $field}
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
			<button class="ajax-link lang" data-class="{$class}" data-function="search_child" data-form="form_side_{$timestamp}" data-db-id="{$db_id}" data-parent_id="{$parent_id}">Search</button>
		</div>
		{else}
			<p class="lang" style="color:#4ba3ff;margin-left:10px;">No search fields are configured</p>
		{/if}
	</div>
{/if}


{if $testserver || $setting.show_developer_panel == 1}
	<div class="db_edit_button_area">
		<button class="ajax-link" invoke-class="db" invoke-function="edit" data-id="{$db_id}" data-mode="screen" data-screen="list_on_side" data-child="true" data-parent_id={$parent_id}>
		<span class="material-symbols-outlined">table</span>
		</button>
	</div>
{/if}

<table style="margin-top:10px;">
<tbody>
{foreach $rows as $row}
	<tr>
		{foreach $group1 as $field}
		<td class="row_style">
			<span class="row_title">{$field["parameter_title"]}</span>
			<span class="row_value">{include file="{$base_template_dir}/__item_viewer.tpl"}</span>
		</td>
		{/foreach}
		<td>
			
		{if $flg_delete_button}
		<button class="ajax-link listbutton" data-class="{$class}" data-function="delete_child" data-id="{$row["_id_enc"]}" data-db_id="{$db_id}" data-parent_id="{$parent_id}" style="float:right;color:#2d2d2d;margin-right:5px;"><span class="material-symbols-outlined">delete</span></button>
		{/if}
		
		{if $flg_edit_button}
		<button class="ajax-link listbutton" data-class="{$class}" data-function="edit_child" data-id="{$row["_id_enc"]}"  data-db_id="{$db_id}" data-parent_id="{$parent_id}" style="float:right;color:#2d2d2d;"><span class="material-symbols-outlined">edit_square</span></button>
		{/if}
		
		

		{foreach $additionals_row as $a}			
			{if $a.button_type == 0}
			<button class="ajax-link lang {$a.show_button_class}" data-class="{$a.class_name}" data-function="{$a.function_name}" data-id="{$row["_id_enc"]}" data-parent_id="{$parent_id}">{$a.button_title}</button>
			{else}
				<button class="ajax-link listbutton {$a.show_button_class}" data-class="{$a.class_name}" data-function="{$a.function_name}"  data-id="{$row["_id_enc"]}" data-parent_id="{$parent_id}" style="color:black;"><span class="material-symbols-outlined">{$a.button_title}</span></button>
			{/if}
		
		{if $testserver || $setting.show_developer_panel == 1}
			{if $a.class_name != "admin"}
				<a style="float:right;margin-left:5px;margin-right:0px;" class="ajax-link" invoke-class="db_additionals" invoke-function="edit" data-id="{$a.id}" data-reload_db_id="{$db_id}"><span class="material-symbols-outlined">smart_toy</span></a>
			{/if}
			{/if}
		{/foreach}
		
		{if $testserver || $setting.show_developer_panel == 1}
			<a style="float:right;margin-left:5px;margin-right:0px;" class="ajax-link" invoke-class="db_additionals" invoke-function="add" data-id="{$db_id}" data-place="3"><span class="material-symbols-outlined">library_add</span></a>
			<a style="float:right;margin-left:5px;margin-right:0px;" class="ajax-link" invoke-class="db_additionals" invoke-function="button_sort" data-tb_name="{$tb_name}" data-place="3"><span class="material-symbols-outlined">overview_key</span></a>
		{/if}
		
		</td>
	</tr>
{/foreach}
</tbody>
</table>

{if $is_last == false}
	<div class="ajax-auto" data-class="{$class}" data-function="rows_child" {if $show_search_box}data-form="form_side_{$timestamp}"{/if} data-max="{$max}" data-db_id="{$db_id}" data-parent_id="{$parent_id}">{$max}</div>
{/if}

<div>
	<div style="float:right;margin-bottom: 8px;">

		
		
		
	</div>
	

	
</div>

<div style="margin-bottom:20px;clear:both;"></div>
