<form id="wizard_parent_child_note_preview_form" onsubmit="return false;">
	<input type="hidden" name="child_tb_name" value="{$row.child_tb_name|escape}">
	<input type="hidden" name="child_db_id" value="{$row.child_db_id|escape}">
	<input type="hidden" name="child_menu_name" value="{$row.child_menu_name|escape}">
	<input type="hidden" name="parent_tb_name" value="{$row.parent_tb_name|escape}">
	<input type="hidden" name="parent_db_id" value="{$row.parent_db_id|escape}">
	<input type="hidden" name="parent_menu_name" value="{$row.parent_menu_name|escape}">
	<input type="hidden" name="dropdown_item" value="{$row.dropdown_item|escape}">
	<input type="hidden" name="dropdown_item_display_type" value="{$row.dropdown_item_display_type|escape}">
	<input type="hidden" name="dropdown_item_template" value="{$row.dropdown_item_template|escape}">
	<input type="hidden" name="list_width" value="{$row.list_width|escape}">
	<input type="hidden" name="cascade_delete_flag" value="{$row.cascade_delete_flag|escape}">

	<table style="width:100%;border-collapse:collapse;font-size:13px;margin-bottom:10px;">
		<tr>
			<th style="width:180px;text-align:left;border:1px solid #d5dbe5;background:#f4f7fb;padding:8px;">親ノート</th>
			<td style="border:1px solid #d5dbe5;padding:8px;">{$row.parent_tb_name|escape} ({$row.parent_menu_name|escape})</td>
		</tr>
		<tr>
			<th style="text-align:left;border:1px solid #d5dbe5;background:#f4f7fb;padding:8px;">子ノート</th>
			<td style="border:1px solid #d5dbe5;padding:8px;">{$row.child_tb_name|escape} ({$row.child_menu_name|escape})</td>
		</tr>
		<tr>
			<th style="text-align:left;border:1px solid #d5dbe5;background:#f4f7fb;padding:8px;">親の表示方法</th>
			<td style="border:1px solid #d5dbe5;padding:8px;">{$row.dropdown_item_display_type_label|escape}</td>
		</tr>
		<tr>
			<th style="text-align:left;border:1px solid #d5dbe5;background:#f4f7fb;padding:8px;">親の表示内容</th>
			<td style="border:1px solid #d5dbe5;padding:8px;">{$row.dropdown_item_template|default:$row.dropdown_item|escape}</td>
		</tr>
		<tr>
			<th style="text-align:left;border:1px solid #d5dbe5;background:#f4f7fb;padding:8px;">子のサイド画面幅</th>
			<td style="border:1px solid #d5dbe5;padding:8px;">{$row.list_width|escape}px</td>
		</tr>
		<tr>
			<th style="text-align:left;border:1px solid #d5dbe5;background:#f4f7fb;padding:8px;">親削除時の子データ削除</th>
			<td style="border:1px solid #d5dbe5;padding:8px;">{$row.cascade_delete_flag_label|escape}</td>
		</tr>
	</table>

	<div style="margin-top:12px;overflow:auto;">
		<button type="button" class="ajax-link" invoke-function="back_to_parent_child_note_basic" style="float:left;">前へ</button>
		<button type="button" class="ajax-link" invoke-function="submit_parent_child_note_exe" data-form="wizard_parent_child_note_preview_form" style="float:right;">保存</button>
	</div>
</form>
