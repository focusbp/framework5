
<div id="left_menu">

	<div style="background:white; padding:10px;">
		
		{if $MYSESSION.app_admin || $MYSESSION.data_manager_permission == 1 }
			<button class="ajax-link lang codex-terminal-menu" data-class="wizard" data-function="run">
				<span class="codex-terminal-menu-label">Codex Terminal</span>
				<span class="codex-terminal-menu-badge">AI</span>
			</button>
		{/if}

		{if $show_dashboard_menu}
			<h3>Dashboard</h3>
			<a class="ajax-link lang" data-class="dashboard" data-function="page">Dashboard</a>
		{/if}

		{if count($database_menu) > 0}
			<h3>Databases</h3>
			{foreach $database_menu as $d}
				<a class="ajax-link lang" data-class="db_exe" data-function="page" data-db_id="{$d.id}">{$d.menu_name}</a>
			{/foreach}
		{/if}

		{if $menu_file != null}
			{include file="$menu_file"}
		{/if}

		{if $setting["show_menu_homepage"] == 1}
			<h3>Public Side</h3>
			{if $setting["show_menu_homepage"] == 1}
				<a href="{$root_url}" target="_blank">Homepage</a>
			{/if}
		{/if}

		{if $MYSESSION.app_admin || $MYSESSION.developer_permission == 1 || $MYSESSION.data_manager_permission == 1}
			<h3>Admin Console</h3>
		{/if}
		{if $MYSESSION.app_admin || $MYSESSION.developer_permission == 1 }
			{if $setting["force_testmode"] == 1 || 
				($setting["force_testmode"] == 0 && $setting["show_developer_panel"] == 1) }
			<a class="ajax-link lang" data-class="panel" data-function="page">Development Panel</a>
			{/if}
		{/if}
		{if $MYSESSION.app_admin || $MYSESSION.data_manager_permission == 1 }
			<a class="ajax-link lang" data-class="panel" data-function="release_backup">Release/Backup</a>
		{/if}
		{if $MYSESSION.app_admin}
			<a class="ajax-link lang" data-class="user" data-function="page">User Management</a>
			<a class="ajax-link lang" data-class="setting" data-function="page">System Setting</a>
		{/if}

		
	</div>
</div>
