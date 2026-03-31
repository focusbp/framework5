<form id="embed_app_snippet_form_{$data.id}">
	<input type="hidden" name="id" value="{$data.id}">
	<table class="custom_events_table">
		<tbody>
			<tr>
				<td style="width:30%;">Snippet</td>
				<td>
					<textarea readonly id="snippet_output_{$data.id}" style="width:100%;height:260px;font-size:11px;">{$snippet_code nofilter}</textarea>
				</td>
			</tr>
		</tbody>
	</table>
	<div style="margin-top:10px;">
		<button type="button" class="snippet-copy-btn" data-target="snippet_output_{$data.id}">Copy</button>
	</div>
</form>

{literal}
<script>
$(function () {
	$('.snippet-copy-btn').off('click').on('click', function () {
		var targetId = $(this).data('target');
		var ta = document.getElementById(targetId);
		if (!ta) {
			return;
		}
		ta.focus();
		ta.select();
		document.execCommand('copy');
		$(this).text('Copied');
		var btn = this;
		setTimeout(function () {
			$(btn).text('Copy');
		}, 1200);
	});
});
</script>
{/literal}
