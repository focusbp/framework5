<div class="edit_100">
	<h4>Custom Events</h4>

	<table class="custom_events_table">
		<thead>
			<tr>
				<th>Event Type</th>
				<th>Class</th>
				<th>Function Name and sample code</th>
				<th>Post Data</th>
				<th>Notes</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td class="code_td">After Create</td>
				<td class="code_td">admin</td><!-- 固定で小文字なら admin -->
				<td class="code_td">function {$data.tb_name}_after_create(Controller $ctl){literal}{{/literal}
	$data_added = $ctl->POST();
{literal}}{/literal}</td>
				<td>$ctl->POST() returns the created record payload.</td>
				<td>Use for post-processing after creation.</td>
			</tr>
			<tr>
				<td class="code_td">After Update</td>
				<td class="code_td">admin</td>
				<td class="code_td">function {$data.tb_name}_after_update(Controller $ctl){literal}{{/literal}
	$data_before = $ctl->POST("before");
	$data_after = $ctl->POST("after");
{literal}}{/literal}</td>
				<td>$ctl->POST("before") returns the record <em>before</em> update.<br/>
					$ctl->POST("after") returns the record <em>after</em> update.</td>
				<td>Prefer using changed_fields for efficient processing.</td>
			</tr>
			<tr>
				<td class="code_td">Before Delete</td>
				<td class="code_td">admin</td>
				<td class="code_td">function {$data.tb_name}_before_delete(Controller $ctl): bool {literal}{{/literal}
	$data = $ctl->POST();
	// return false to cancel deletion; true to proceed
	return true;
{literal}}{/literal}</td>
				<td>$ctl->POST() provides the record to be deleted (pre-delete attributes).</td>
				<td><strong>Return</strong> false to cancel; true to proceed.</td>
			</tr>
			<tr>
				<td class="code_td">After Delete</td>
				<td class="code_td">admin</td>
				<td class="code_td">function {$data.tb_name}_after_delete(Controller $ctl){literal}{{/literal}
	$data = $ctl->POST();
{literal}}{/literal}</td>
				<td>$ctl->POST() typically includes identifiers (e.g., id).</td>
				<td>For pre-delete attributes, use the <em>Before Delete</em> hook.</td>
			</tr>
			<tr>
				<td class="code_td">After Duplicate</td>
				<td class="code_td">admin</td>
				<td class="code_td">function {$data.tb_name}_after_duplicate(Controller $ctl){literal}{
    $original = $ctl->POST("original");
    $copy = $ctl->POST("copy");
}{/literal}</td>
				<td>
					$ctl->POST("original") returns the original record snapshot.<br/>
					$ctl->POST("copy") returns the duplicated record.
				</td>
				<td>Use for post-processing after duplication (cannot cancel here).</td>
			</tr>


		</tbody>
	</table>
</div>

