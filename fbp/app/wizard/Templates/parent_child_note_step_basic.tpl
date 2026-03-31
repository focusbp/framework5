<form id="wizard_parent_child_note_basic_form" onsubmit="return false;">
	<p style="font-size:13px;color:#374151;margin:0 0 10px 0;">親子に関する設定のみ変更します。</p>

	<div style="padding:10px;border:1px solid #d5dbe5;background:#f8fafc;margin-bottom:12px;">
		<p style="margin:0 0 4px 0;font-weight:bold;">対象</p>
		<p style="margin:0;font-size:13px;">親: {$row.parent_tb_name|escape} ({$row.parent_menu_name|escape})</p>
		<p style="margin:4px 0 0 0;font-size:13px;">子: {$row.child_tb_name|escape} ({$row.child_menu_name|escape})</p>
	</div>

	<p style="font-weight:bold;margin:0 0 8px 0;">親の設定</p>
	<div style="display:grid;grid-template-columns:repeat(2,minmax(0,1fr));gap:12px;">
		<div>
			<p style="margin:0 0 4px 0;">表示方法 *</p>
			{html_options name="dropdown_item_display_type" options=$dropdown_item_display_type_options selected=$row.dropdown_item_display_type}
			<p class="error_message error_dropdown_item_display_type"></p>
		</div>
		<div>
			<p style="margin:0 0 4px 0;">表示フィールド</p>
			{html_options name="dropdown_item" options=$dropdown_item_options selected=$row.dropdown_item}
			<p class="error_message error_dropdown_item"></p>
		</div>
	</div>

	<p style="margin:12px 0 4px 0;">表示テンプレート</p>
	<input type="text" name="dropdown_item_template" value="{$row.dropdown_item_template|escape}" style="width:100%;" placeholder="例: 氏名 (ID)">
	<p class="error_message error_dropdown_item_template"></p>
	<p style="margin:6px 0 0 0;font-size:12px;color:#6b7280;">`Multiple Fields (Template)` を選んだ場合のみ使用します。</p>

	<p style="font-weight:bold;margin:16px 0 8px 0;">子の設定</p>
	<div style="display:grid;grid-template-columns:repeat(2,minmax(0,1fr));gap:12px;">
		<div>
			<p style="margin:0 0 4px 0;">サイド画面幅 *</p>
			<input type="text" name="list_width" value="{$row.list_width|escape}" style="width:100%;">
			<p class="error_message error_list_width"></p>
		</div>
		<div>
			<p style="margin:0 0 4px 0;">親削除時の子データ削除 *</p>
			{html_options name="cascade_delete_flag" options=$cascade_delete_flag_options selected=$row.cascade_delete_flag}
			<p class="error_message error_cascade_delete_flag"></p>
		</div>
	</div>

	<div style="margin-top:12px;overflow:auto;">
		<button type="button" class="ajax-link" invoke-function="back_to_parent_child_note_child" style="float:left;">前へ</button>
		<button type="button" class="ajax-link" invoke-function="submit_parent_child_note_basic_next" data-form="wizard_parent_child_note_basic_form" style="float:right;">次へ</button>
	</div>
</form>
