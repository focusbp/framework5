<div id="minimal_calendar_original_management_calendar_area">
    <div class="original_screen_toolbar">
        <button type="button" class="ajax-link" data-class="minimal_calendar_original_management" data-function="set_week" data-mode="previous">前週</button>
        <button type="button" class="ajax-link" data-class="minimal_calendar_original_management" data-function="set_week" data-mode="next">次週</button>
        <span class="original_calendar_week_label">{$week_label}</span>
    </div>
    <div class="original_calendar_grid original_calendar_grid_compact">
        {foreach from=$calendar_days item=day}
            <div class="original_calendar_day_bar">
                <div class="original_calendar_box original_calendar_box_compact">
                    <strong>{$day.date_label}</strong>（{$day.day_label}）
                </div>
                {foreach from=$day.hours item=hour}
                    <div class="original_calendar_slot">
                        {if !is_array($assigned[$hour.target_time])}
                            {$hour.label}
                        {/if}
                        {foreach from=$assigned[$hour.target_time] item=row}
                            <div class="original_calendar_task_compact">
                                {$row.start_time} {$row.title|escape}
                            </div>
                        {/foreach}
                    </div>
                {/foreach}
            </div>
        {/foreach}
    </div>
</div>
