<form id="sample_note_original_management_delete_form">
    <input type="hidden" name="id" value="{$row.id|escape}">
    <p class="original_screen_confirm_message">「{$row.title|escape}」を削除しますか？</p>
    <div class="original_screen_dialog_actions">
        <button type="button" class="ajax-link button_link" data-class="sample_note_original_management" data-function="delete_execute" data-form="sample_note_original_management_delete_form">削除する</button>
    </div>
</form>
