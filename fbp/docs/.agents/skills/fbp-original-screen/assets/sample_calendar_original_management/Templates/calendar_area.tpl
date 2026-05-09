<div id="sample_calendar_original_management_calendar_area">
    <div class="original_calendar_toolbar">
        <div class="original_calendar_toolbar_main">
            <div class="original_calendar_nav">
                <button type="button" class="ajax-link ui-button ui-corner-all original_calendar_change_week_button" data-class="sample_calendar_original_management" data-function="set_week" data-mode="previous">
                    <span class="material-symbols-outlined">chevron_left</span>
                </button>
                <button type="button" class="ajax-link ui-button ui-corner-all original_calendar_change_week_button" data-class="sample_calendar_original_management" data-function="set_week" data-mode="current">
                    <span class="material-symbols-outlined">today</span>
                </button>
                <button type="button" class="ajax-link ui-button ui-corner-all original_calendar_change_week_button" data-class="sample_calendar_original_management" data-function="set_week" data-mode="next">
                    <span class="material-symbols-outlined">chevron_right</span>
                </button>
            </div>

            <div class="original_calendar_datepicker_area original_calendar_jump_compact">
                <form id="sample_calendar_original_management_jump_form">
                    <input type="hidden" name="mode" value="jump">
                    <input type="text" name="jump_date" class="datepicker original_calendar_jump_input" value="{$jump_date}">
                    <button type="button" class="ajax-link ui-button ui-corner-all" data-class="sample_calendar_original_management" data-function="set_week" data-form="sample_calendar_original_management_jump_form">
                        <span class="material-symbols-outlined">keyboard_return</span>
                    </button>
                </form>
            </div>

            <div class="original_calendar_heading">
                <span>{$week_label}</span>
                <span class="original_calendar_timezone">{$timezone_label|escape}</span>
            </div>
        </div>
        <div class="original_calendar_add_action">
            <button type="button" class="ajax-link button_link" data-class="sample_calendar_original_management" data-function="add_dialog">追加</button>
        </div>
    </div>

    <div class="original_calendar_grid">
        {foreach from=$calendar_days item=day}
            <div class="original_calendar_day_bar">
                <div class="original_calendar_box days_{$day.day_label|escape}">
                    <p class="calendar_title">
                        <span class="original_calendar_title_date">{$day.date_label}</span>
                        <span class="day">（{$day.day_label}）</span>
                    </p>
                </div>

                {foreach from=$day.hours item=hour}
                    <div class="original_calendar_box {$occupied_travel[$hour.target_time]} {$occupied[$hour.target_time]}" data-datetime="{$hour.target_time}">
                        {if !is_array($assigned[$hour.target_time])}
                            <p>{$hour.label}</p>
                        {/if}
                        {foreach from=$assigned_travel[$hour.target_time] item=travel}
                            <div class="original_calendar_travel_marker {if $travel.type == "before"}original_calendar_travel_before{else}original_calendar_travel_after{/if}">
                                {if $travel.type == "before"}移動開始{else}移動終了{/if} {$travel.time}
                            </div>
                        {/foreach}
                        {foreach from=$assigned[$hour.target_time] item=row}
                            <div class="original_calendar_task active_indicator">
                                <span class="original_calendar_controlbox">
                                    <button type="button" class="ajax-link listbutton original_screen_action_delete" data-class="sample_calendar_original_management" data-function="delete_confirm" data-id="{$row.id}">
                                        <span class="material-symbols-outlined">delete</span>
                                    </button>
                                    <button type="button" class="ajax-link listbutton original_screen_action_edit" data-class="sample_calendar_original_management" data-function="edit_dialog" data-id="{$row.id}">
                                        <span class="material-symbols-outlined">edit_square</span>
                                    </button>
                                </span>
                                <span class="original_calendar_task_time">{$row.start_time} - {$row.end_time}</span>
                                <div class="original_calendar_task_message">
                                    <div class="row_style">
                                        <span class="row_value"><p>{$row.title|escape}</p></span>
                                    </div>
                                    {if $row.travel_start_time != "" || $row.travel_end_time != ""}
                                        <div class="row_style">
                                            <span class="row_value">
                                                <p>
                                                    {if $row.travel_start_time != ""}移動前 {$row.travel_start_time}{/if}
                                                    {if $row.travel_start_time != "" && $row.travel_end_time != ""} / {/if}
                                                    {if $row.travel_end_time != ""}移動後 {$row.travel_end_time}{/if}
                                                </p>
                                            </span>
                                        </div>
                                    {/if}
                                    {if $row.status != ""}
                                        <div class="row_style">
                                            <span class="row_value"><p>{fields_view_direct db="sample_schedule" fields="status" data=$row}</p></span>
                                        </div>
                                    {/if}
                                    {if $row.detail != ""}
                                        <div class="row_style">
                                            <span class="row_value"><p>{$row.detail|escape|nl2br}</p></span>
                                        </div>
                                    {/if}
                                </div>
                            </div>
                        {/foreach}
                    </div>
                {/foreach}
            </div>
        {/foreach}
    </div>
</div>
