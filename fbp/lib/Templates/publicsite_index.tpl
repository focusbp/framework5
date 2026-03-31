<!DOCTYPE html>
<html>
<head>
{include file="{$base_template_dir}/publicsite_header.tpl"}
{$html_header}
</head>

<body class="publicsite-body">
	{assign "publicsite_logo_url" $ctl->get_APP_URL("public_asset_media", "view", ["key" => "asset_65bbfbb3bcb7"])}
	{assign "publicsite_brand_url" "#"}
	{if count($publicsite_menu_items) > 0}
		{assign "publicsite_brand_url" $publicsite_menu_items[0].url}
	{/if}
    <article class="class_style_{$class} lang_check_area publicsite-shell" data-classname="{$class}" style="--publicsite-hero-image:url('{$publicsite_logo_url nofilter}');">
		<header class="publicsite-site-header">
			<a href="{$publicsite_brand_url}" class="publicsite-brand">
				<img src="{$publicsite_logo_url}" alt="株式会社組織改革" class="publicsite-brand-media">
				<span class="publicsite-brand-copy">
					<span class="publicsite-brand-overline">Business Reform</span>
					<span class="publicsite-brand-name">株式会社組織改革</span>
				</span>
			</a>
			{if count($publicsite_menu_items) > 0}
				<button type="button" class="publicsite-menu-toggle" data-publicsite-menu-toggle aria-expanded="false" aria-controls="publicsite-menu-panel" aria-label="メニューを開く">
					<span></span>
				</button>
			{/if}
		</header>

		{if count($publicsite_menu_items) > 0}
			<div class="publicsite-menu-backdrop" data-publicsite-menu-backdrop></div>
			<nav id="publicsite-menu-panel" class="publicsite-menu-panel" data-publicsite-menu aria-hidden="true">
				<p class="publicsite-menu-label">Navigation</p>
				{foreach $publicsite_menu_items as $menu}
					<a href="{$menu.url}" class="publicsite-menu-link{if $menu.selected == 1} is-active{/if}">{$menu.label|escape}</a>
				{/foreach}
			</nav>
		{/if}

		<section class="public_main_section">
			<div class="publicsite-main-inner">
				<div id="multi_dialog_{$class}" class="getting_dialog_id publicsite-content">
{$contents nofilter}
				</div>
			</div>
		</section>

		<footer class="publicsite-site-footer">
			<div class="publicsite-footer-company">株式会社組織改革</div>
			<div class="publicsite-footer-copy">&copy; {$timestamp|date_format:"%Y"} 株式会社組織改革</div>
		</footer>
			
	</article>
	
	{include file="{$base_template_dir}/publicsite_footer.tpl"}
</body>
</html>
