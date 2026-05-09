<div id="minimal_note_original_management_list_area">
    <table class="original_screen_simple_table">
        <tbody>
            {foreach from=$rows item=row}
                <tr>
                    <td class="original_screen_simple_cell">{$row.id}</td>
                    <td class="original_screen_simple_cell">{$row.title|escape}</td>
                    <td class="original_screen_simple_cell">{fields_view_direct db="sample_note" fields="status" data=$row}</td>
                    <td class="original_screen_simple_cell original_screen_simple_cell_end">
                        <button type="button" class="ajax-link" data-class="minimal_note_original_management" data-function="edit_dialog" data-id="{$row.id}">編集</button>
                        <button type="button" class="ajax-link" data-class="minimal_note_original_management" data-function="delete_dialog" data-id="{$row.id}">削除</button>
                    </td>
                </tr>
            {/foreach}
        </tbody>
    </table>
</div>
