<div class="original_screen_dialog_panel">
    <p class="original_screen_text_message">「{$row.title|escape}」を削除します。</p>
    <div class="original_screen_dialog_actions">
        <button type="button" class="button_link_close" onclick="close_multi_dialog('sample_sort_original_management_delete');">キャンセル</button>
        <button type="button" class="ajax-link button_link" data-class="sample_sort_original_management" data-function="delete_execute" data-id="{$row.id}" style="background:#dc2626;border-color:#dc2626;">削除</button>
    </div>
</div>
