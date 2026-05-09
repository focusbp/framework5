<div id="minimal_sort_original_management_list_area">
    <table class="original_screen_table">
        <tbody id="minimal_sort_original_management_sortable">
            {foreach $rows as $row}
                <tr id="{$row.id}" class="dragable-item">
                    <td class="original_screen_sort_handle_cell">
                        <span class="material-symbols-outlined handle original_screen_sort_handle">swap_vert</span>
                    </td>
                    <td class="row_style" style="width:90px;">
                        <span class="row_title">順番</span>
                        <span class="row_value"><p>{$row.sort|escape}</p></span>
                    </td>
                    <td class="row_style">
                        <span class="row_title">タイトル</span>
                        <span class="row_value"><p>{$row.title|escape}</p></span>
                    </td>
                    <td class="row_style">
                        <span class="row_title">メモ</span>
                        <span class="row_value"><p>{$row.note|escape}</p></span>
                    </td>
                    <td class="original_screen_action_cell">
                        <button type="button" class="ajax-link listbutton original_screen_action_delete" data-class="minimal_sort_original_management" data-function="delete_dialog" data-id="{$row.id}">
                            <span class="material-symbols-outlined">delete</span>
                        </button>
                        <button type="button" class="ajax-link listbutton original_screen_action_edit" data-class="minimal_sort_original_management" data-function="edit_dialog" data-id="{$row.id}">
                            <span class="material-symbols-outlined">edit_square</span>
                        </button>
                    </td>
                </tr>
            {/foreach}
            {if count($rows) === 0}
                <tr>
                    <td colspan="5" class="original_screen_empty_row">データはありません。</td>
                </tr>
            {/if}
        </tbody>
    </table>
</div>

<script>
(function ($) {
    var selector = "#minimal_sort_original_management_sortable";
    if ($(selector).hasClass("ui-sortable")) {
        $(selector).sortable("destroy");
    }
    $(selector).sortable({
        handle: ".handle",
        cancel: "button",
        axis: "y",
        update: function () {
            var log = $(this).sortable("toArray");
            var fd = new FormData();
            fd.append("class", "minimal_sort_original_management");
            fd.append("function", "sort_save");
            fd.append("log", log);
            appcon("app.php", fd);
        }
    });
})(jQuery);
</script>
