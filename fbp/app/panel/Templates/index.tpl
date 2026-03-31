<div id="setting_panel_tabs">
	<ul>
		<li><a href="#tabs-db" invoke-class="db" invoke-function="page">Database</a></li>
		<li><a href="#tabs-dashboard" invoke-class="dashboard" invoke-function="list">Dashboard</a></li>
		<li><a href="#tabs-constants" invoke-class="panel_constants" invoke-function="page">Constants</a></li>
		<li><a href="#tabs-webhook" invoke-class="webhook_rule" invoke-function="page">Webhook</a></li>
		<li><a href="#tabs-embed-app" invoke-class="embed_app" invoke-function="page">Embed App</a></li>
		<li><a href="#tabs-public-pages" invoke-class="public_pages_registry" invoke-function="page">Public Pages</a></li>
		<li><a href="#tabs-public-assets" invoke-class="public_assets" invoke-function="page">Public Assets</a></li>
		<li><a href="#tabs-buttons" invoke-class="db_additionals" invoke-function="list">DB Additionals</a></li>
		<li><a href="#tabs-cron" invoke-class="cron" invoke-function="page">Cron</a></li>
		<li><a href="#tabs-mail" invoke-class="email_format" invoke-function="page">Email Templates</a></li>
		<li><a href="#tabs-translate" invoke-class="lang" invoke-function="showlist">Translate</a></li>
	</ul>
	<div id="tabs-db">
	</div>
	<div id="tabs-dashboard">
	</div>
	<div id="tabs-constants">
	</div>
	<div id="tabs-webhook">
	</div>
	<div id="tabs-embed-app">
	</div>
	<div id="tabs-public-pages">
	</div>
	<div id="tabs-public-assets">
	</div>
	<div id="tabs-buttons">
	</div>
	<div id="tabs-cron">
	</div>
	<div id="tabs-mail">
	</div>
	<div id="tabs-translate">
	</div>
</div>

<script>
	$(function () {
		// jQuery UI Tabs 初期化
		$("#setting_panel_tabs").tabs({
		});
	});
</script>
