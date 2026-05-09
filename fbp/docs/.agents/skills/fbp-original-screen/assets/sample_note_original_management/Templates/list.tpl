<div class="original_screen_page">
    <div class="original_screen_toolbar original_screen_toolbar_end">
        <button type="button" class="ajax-link button_link" data-class="sample_note_original_management" data-function="add_dialog">追加</button>
    </div>

    <div class="search_box original_search_panel">
        <p class="original_search_panel_title">検索条件</p>
        <div class="original_search_panel_body">
            <div class="search_left">
                <form id="sample_note_original_management_filter_form" class="search_form_flex">
                    <div class="search_form_item field_type_dropdown">
                        {fields_form_original name="status" type="dropdown" value=$filter.status options_arr=$status_options title="ステータス" item_margin_top="0px"}
                    </div>
                    <div class="search_form_item field_type_text">
                        {fields_form_original name="keyword" type="text" value=$filter.keyword title="キーワード" item_margin_top="0px"}
                    </div>
                    <button type="button" class="ajax-link original_screen_hidden_trigger" data-class="sample_note_original_management" data-function="apply_filter" data-form="sample_note_original_management_filter_form" id="sample_note_original_management_filter_trigger"></button>
                </form>
            </div>
        </div>
    </div>

    <script>
    (function ($) {
        var timer = null;
        $(document).off("change.sampleNoteFilter", "#sample_note_original_management_filter_form select");
        $(document).on("change.sampleNoteFilter", "#sample_note_original_management_filter_form select", function () {
            $("#sample_note_original_management_filter_trigger").trigger("click");
        });
        $(document).off("input.sampleNoteFilter", "#sample_note_original_management_filter_form input[name='keyword']");
        $(document).on("input.sampleNoteFilter", "#sample_note_original_management_filter_form input[name='keyword']", function () {
            clearTimeout(timer);
            timer = setTimeout(function () {
                $("#sample_note_original_management_filter_trigger").trigger("click");
            }, 300);
        });
    })(jQuery);
    </script>

    {include file="list_area.tpl"}
</div>
