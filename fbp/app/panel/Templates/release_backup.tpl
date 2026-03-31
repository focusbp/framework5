<div id="setting_panel_tabs">
	<ul>
		<li><a href="#tabs-1" invoke-class="panel" invoke-function="release_backup">Release / Backup</a></li>
	</ul>
	<div id="tabs-1" style="display: block;overflow: hidden;">

		<table class="release-table">
			{if !$MYSESSION.testserver}
				<tr>
					<td>
						<button class="ajax-link lang"
								data-class="release"
								data-function="release"
								style="float:inherit;margin-top:0px;">Release</button>
					</td>
					<td>
						<span class="lang">Deploy the tested version to the live environment.</span>
					</td>
				</tr>
			{/if}
			<tr>
				<td>
					<button class="ajax-link lang"
							data-class="restore"
							data-function="download_zip"
							style="float:inherit;margin-top:0px;">Backup</button>
				</td>
				<td>
					<span class="lang">Download a backup archive of the current system.</span>
				</td>
			</tr>
			<tr>
				<td>
					<button class="ajax-link lang"
							data-class="restore"
							data-function="restore"
							style="float:inherit;margin-top:0px;">Restore</button>
				</td>
				<td>
					<span class="lang">Restore the system from a selected backup archive.</span>
				</td>
			</tr>
		</table>


	</div>
</div>

<script>
	$(function () {
		// jQuery UI Tabs 初期化
		$("#setting_panel_tabs").tabs({
		});
	});
</script>
