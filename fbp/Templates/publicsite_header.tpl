<meta charset="utf-8">

<meta name="viewport" content="{$viewport_public}">

{include file="./_css.tpl"}

<link rel="stylesheet" href="css/appstyle.css?{$timestamp}">
<link rel="stylesheet" href="appcss.php?class={$class}&css_class={$css_class}&{$timestamp}">
<link rel="icon" href="app.php?class=upload&function=favicon" type="image/x-icon" id="favicon">

<style>
	:root {
		--publicsite-primary: #0f3d73;
		--publicsite-primary-deep: #09233f;
		--publicsite-accent: #2b7fc1;
		--publicsite-surface: rgba(255, 255, 255, 0.94);
		--publicsite-border: rgba(15, 61, 115, 0.14);
		--publicsite-shadow: 0 28px 56px rgba(9, 35, 63, 0.14);
		--publicsite-text: #16324f;
		--publicsite-muted: #5b6f84;
	}

	html {
		background:
			linear-gradient(180deg, #eef5fb 0%, #f7fbff 36%, #edf3f8 100%);
	}

	body.publicsite-body {
		margin: 0;
		color: var(--publicsite-text);
		background: transparent;
		font-family: "Hiragino Sans", "Yu Gothic", sans-serif;
	}

	.publicsite-shell {
		position: relative;
		min-height: 100vh;
		overflow: hidden;
	}

	.publicsite-shell::before {
		content: "";
		position: fixed;
		inset: 0;
		background:
			linear-gradient(135deg, rgba(15, 61, 115, 0.9) 0%, rgba(43, 127, 193, 0.72) 38%, rgba(255, 255, 255, 0) 72%),
			var(--publicsite-hero-image, none) center top / cover no-repeat;
		opacity: 0.2;
		filter: saturate(0.9);
		pointer-events: none;
		z-index: 0;
	}

	.publicsite-site-header,
	.publicsite-main-inner,
	.publicsite-site-footer {
		position: relative;
		z-index: 1;
	}

	.publicsite-site-header {
		position: sticky;
		top: 0;
		display: flex;
		align-items: center;
		justify-content: space-between;
		gap: 20px;
		padding: 18px 24px;
		backdrop-filter: blur(18px);
		background: rgba(255, 255, 255, 0.84);
		border-bottom: 1px solid rgba(15, 61, 115, 0.1);
		box-shadow: 0 10px 30px rgba(9, 35, 63, 0.08);
	}

	.publicsite-brand {
		display: inline-flex;
		align-items: center;
		gap: 14px;
		color: var(--publicsite-primary-deep);
		text-decoration: none;
		min-width: 0;
	}

	.publicsite-brand-media {
		width: 56px;
		height: 56px;
		border-radius: 18px;
		object-fit: cover;
		box-shadow: 0 12px 24px rgba(15, 61, 115, 0.18);
		background: #d7e6f4;
		flex-shrink: 0;
	}

	.publicsite-brand-copy {
		min-width: 0;
	}

	.publicsite-brand-overline {
		display: block;
		font-size: 11px;
		font-weight: 700;
		letter-spacing: 0.18em;
		text-transform: uppercase;
		color: var(--publicsite-accent);
	}

	.publicsite-brand-name {
		display: block;
		font-size: 18px;
		font-weight: 700;
		line-height: 1.3;
		letter-spacing: 0.04em;
	}

	.publicsite-menu-toggle {
		position: relative;
		display: inline-flex;
		align-items: center;
		justify-content: center;
		width: 52px;
		height: 52px;
		padding: 0;
		border: 1px solid rgba(15, 61, 115, 0.16);
		border-radius: 18px;
		background: rgba(15, 61, 115, 0.94);
		color: #fff;
		cursor: pointer;
		box-shadow: 0 18px 30px rgba(9, 35, 63, 0.16);
		transition: transform 0.18s ease, box-shadow 0.18s ease, background 0.18s ease;
	}

	.publicsite-menu-toggle:hover,
	.publicsite-menu-toggle:focus-visible {
		transform: translateY(-1px);
		box-shadow: 0 22px 36px rgba(9, 35, 63, 0.2);
		background: rgba(9, 35, 63, 0.98);
	}

	.publicsite-menu-toggle span,
	.publicsite-menu-toggle::before,
	.publicsite-menu-toggle::after {
		content: "";
		display: block;
		width: 22px;
		height: 2px;
		border-radius: 999px;
		background: currentColor;
		transition: transform 0.18s ease, opacity 0.18s ease;
	}

	.publicsite-menu-toggle span {
		position: relative;
	}

	.publicsite-menu-toggle::before {
		position: absolute;
		transform: translateY(-7px);
	}

	.publicsite-menu-toggle::after {
		position: absolute;
		transform: translateY(7px);
	}

	body.publicsite-menu-open .publicsite-menu-toggle span {
		opacity: 0;
	}

	body.publicsite-menu-open .publicsite-menu-toggle::before {
		transform: rotate(45deg);
	}

	body.publicsite-menu-open .publicsite-menu-toggle::after {
		transform: rotate(-45deg);
	}

	.publicsite-menu-panel {
		position: fixed;
		top: 92px;
		right: 24px;
		width: min(320px, calc(100vw - 32px));
		padding: 20px;
		border: 1px solid rgba(15, 61, 115, 0.12);
		border-radius: 24px;
		background: rgba(255, 255, 255, 0.96);
		box-shadow: var(--publicsite-shadow);
		opacity: 0;
		transform: translateY(-10px);
		pointer-events: none;
		transition: opacity 0.18s ease, transform 0.18s ease;
		z-index: 4;
	}

	body.publicsite-menu-open .publicsite-menu-panel {
		opacity: 1;
		transform: translateY(0);
		pointer-events: auto;
	}

	.publicsite-menu-label {
		margin: 0 0 10px;
		font-size: 11px;
		font-weight: 700;
		letter-spacing: 0.18em;
		text-transform: uppercase;
		color: var(--publicsite-accent);
	}

	.publicsite-menu-link {
		display: flex;
		align-items: center;
		justify-content: space-between;
		gap: 12px;
		padding: 16px 18px;
		border-radius: 18px;
		background: linear-gradient(135deg, rgba(15, 61, 115, 0.1) 0%, rgba(43, 127, 193, 0.16) 100%);
		color: var(--publicsite-primary-deep);
		font-size: 15px;
		font-weight: 700;
		text-decoration: none;
	}

	.publicsite-menu-link.is-active {
		background: linear-gradient(135deg, rgba(15, 61, 115, 0.92) 0%, rgba(43, 127, 193, 0.92) 100%);
		color: #fff;
		box-shadow: 0 16px 26px rgba(9, 35, 63, 0.18);
	}

	.publicsite-menu-link::after {
		content: ">";
		font-size: 15px;
		line-height: 1;
	}

	.publicsite-menu-backdrop {
		position: fixed;
		inset: 0;
		background: rgba(9, 35, 63, 0.28);
		opacity: 0;
		pointer-events: none;
		transition: opacity 0.18s ease;
		z-index: 3;
	}

	body.publicsite-menu-open .publicsite-menu-backdrop {
		opacity: 1;
		pointer-events: auto;
	}

	.public_main_section {
		padding: 44px 24px 72px;
	}

	.publicsite-main-inner {
		max-width: 1180px;
		margin: 0 auto;
	}

	.publicsite-content {
		padding: 36px;
		border: 1px solid var(--publicsite-border);
		border-radius: 32px;
		background: var(--publicsite-surface);
		box-shadow: var(--publicsite-shadow);
	}

	.publicsite-site-footer {
		display: flex;
		align-items: center;
		justify-content: space-between;
		gap: 16px;
		padding: 24px;
		color: #eef5fb;
		background: linear-gradient(135deg, rgba(9, 35, 63, 0.98) 0%, rgba(15, 61, 115, 0.94) 100%);
	}

	.publicsite-footer-company {
		font-size: 15px;
		font-weight: 700;
		letter-spacing: 0.06em;
	}

	.publicsite-footer-copy {
		font-size: 13px;
		color: rgba(238, 245, 251, 0.76);
	}

	.public-contact-page {
		display: grid;
		gap: 24px;
	}

	.public-contact-hero {
		display: grid;
		grid-template-columns: minmax(0, 1.3fr) minmax(280px, 0.9fr);
		gap: 24px;
		align-items: stretch;
	}

	.public-contact-copy {
		padding: 10px 0;
	}

	.public-contact-kicker {
		display: inline-flex;
		padding: 8px 14px;
		border-radius: 999px;
		background: rgba(43, 127, 193, 0.12);
		color: var(--publicsite-accent);
		font-size: 11px;
		font-weight: 700;
		letter-spacing: 0.16em;
		text-transform: uppercase;
	}

	.public-contact-title {
		margin: 18px 0 14px;
		font-size: clamp(32px, 5vw, 52px);
		line-height: 1.08;
		letter-spacing: 0.03em;
		color: var(--publicsite-primary-deep);
	}

	.public-contact-lead {
		margin: 0;
		font-size: 16px;
		line-height: 1.9;
		color: var(--publicsite-muted);
	}

	.public-contact-card {
		padding: 28px;
		border-radius: 28px;
		background: linear-gradient(160deg, rgba(15, 61, 115, 0.97) 0%, rgba(34, 101, 161, 0.94) 100%);
		color: #fff;
		box-shadow: 0 24px 40px rgba(15, 61, 115, 0.2);
	}

	.public-contact-card-title {
		margin: 0 0 18px;
		font-size: 22px;
		font-weight: 700;
	}

	.public-contact-card-copy {
		margin: 0 0 22px;
		font-size: 14px;
		line-height: 1.85;
		color: rgba(255, 255, 255, 0.8);
	}

	.public-contact-points {
		margin: 0;
		padding: 0;
		list-style: none;
		display: grid;
		gap: 10px;
	}

	.public-contact-points li {
		padding: 14px 16px;
		border-radius: 18px;
		background: rgba(255, 255, 255, 0.1);
		font-size: 14px;
		line-height: 1.65;
	}

	.public-contact-visual {
		position: relative;
		min-height: 320px;
		border-radius: 30px;
		overflow: hidden;
		background:
			linear-gradient(180deg, rgba(9, 35, 63, 0.08) 0%, rgba(9, 35, 63, 0.54) 100%),
			var(--publicsite-hero-image, none) center center / cover no-repeat;
		box-shadow: 0 24px 44px rgba(9, 35, 63, 0.18);
	}

	.public-contact-visual::after {
		content: "";
		position: absolute;
		inset: auto 20px 20px;
		height: 1px;
		background: rgba(255, 255, 255, 0.32);
	}

	.public-contact-visual-copy {
		position: absolute;
		inset: auto 24px 28px;
		color: #fff;
	}

	.public-contact-visual-copy strong {
		display: block;
		font-size: 24px;
		font-weight: 700;
		margin-bottom: 8px;
	}

	.public-contact-visual-copy span {
		display: block;
		font-size: 13px;
		line-height: 1.7;
		color: rgba(255, 255, 255, 0.8);
	}

	.public-job-page {
		display: grid;
		gap: 28px;
	}

	.public-job-hero {
		display: grid;
		grid-template-columns: minmax(0, 1.2fr) minmax(300px, 0.88fr);
		gap: 24px;
		align-items: stretch;
	}

	.public-job-copy {
		padding: 6px 0;
	}

	.public-job-kicker {
		display: inline-flex;
		padding: 8px 14px;
		border-radius: 999px;
		background: rgba(43, 127, 193, 0.12);
		color: var(--publicsite-accent);
		font-size: 11px;
		font-weight: 700;
		letter-spacing: 0.16em;
		text-transform: uppercase;
	}

	.public-job-title {
		margin: 18px 0 16px;
		font-size: clamp(34px, 5.2vw, 56px);
		line-height: 1.06;
		letter-spacing: 0.03em;
		color: var(--publicsite-primary-deep);
	}

	.public-job-lead {
		margin: 0;
		font-size: 16px;
		line-height: 1.9;
		color: var(--publicsite-muted);
	}

	.public-job-actions {
		display: flex;
		flex-wrap: wrap;
		align-items: center;
		gap: 14px 18px;
		margin-top: 24px;
	}

	.public-job-primary-link {
		display: inline-flex;
		align-items: center;
		justify-content: center;
		padding: 14px 22px;
		border-radius: 999px;
		background: linear-gradient(135deg, rgba(15, 61, 115, 0.98) 0%, rgba(43, 127, 193, 0.94) 100%);
		color: #fff;
		font-size: 14px;
		font-weight: 700;
		text-decoration: none;
		box-shadow: 0 16px 30px rgba(15, 61, 115, 0.18);
	}

	.public-job-note {
		font-size: 13px;
		line-height: 1.7;
		color: var(--publicsite-muted);
	}

	.public-job-visual {
		position: relative;
		min-height: 360px;
		border-radius: 32px;
		overflow: hidden;
		background:
			linear-gradient(180deg, rgba(9, 35, 63, 0.1) 0%, rgba(9, 35, 63, 0.66) 100%),
			var(--publicsite-job-image, none) center center / cover no-repeat;
		box-shadow: 0 26px 44px rgba(9, 35, 63, 0.18);
	}

	.public-job-visual-card {
		position: absolute;
		right: 22px;
		bottom: 22px;
		left: 22px;
		padding: 22px;
		border: 1px solid rgba(255, 255, 255, 0.16);
		border-radius: 24px;
		background: rgba(9, 35, 63, 0.56);
		backdrop-filter: blur(10px);
		color: #fff;
	}

	.public-job-visual-card strong {
		display: block;
		margin-bottom: 8px;
		font-size: 14px;
		font-weight: 700;
		letter-spacing: 0.08em;
	}

	.public-job-visual-card span {
		display: block;
		font-size: 18px;
		line-height: 1.6;
	}

	.public-job-grid {
		display: grid;
		grid-template-columns: repeat(3, minmax(0, 1fr));
		gap: 20px;
	}

	.public-job-panel {
		padding: 24px;
		border: 1px solid rgba(15, 61, 115, 0.1);
		border-radius: 26px;
		background: rgba(255, 255, 255, 0.9);
	}

	.public-job-panel-accent {
		background: linear-gradient(165deg, rgba(15, 61, 115, 0.98) 0%, rgba(43, 127, 193, 0.92) 100%);
		color: #fff;
		box-shadow: 0 22px 36px rgba(15, 61, 115, 0.18);
	}

	.public-job-section-title {
		margin: 0 0 16px;
		font-size: 21px;
		font-weight: 700;
		color: inherit;
	}

	.public-job-list {
		margin: 0;
		padding: 0;
		list-style: none;
		display: grid;
		gap: 12px;
	}

	.public-job-list li {
		padding-left: 18px;
		position: relative;
		font-size: 14px;
		line-height: 1.8;
		color: inherit;
	}

	.public-job-list li::before {
		content: "";
		position: absolute;
		top: 10px;
		left: 0;
		width: 8px;
		height: 8px;
		border-radius: 999px;
		background: rgba(43, 127, 193, 0.86);
	}

	.public-job-panel-accent .public-job-list li::before {
		background: rgba(255, 255, 255, 0.86);
	}

	.public-job-detail-list {
		margin: 0;
		display: grid;
		gap: 14px;
	}

	.public-job-detail-list div {
		padding-bottom: 14px;
		border-bottom: 1px solid rgba(255, 255, 255, 0.18);
	}

	.public-job-detail-list div:last-child {
		padding-bottom: 0;
		border-bottom: 0;
	}

	.public-job-detail-list dt {
		margin: 0 0 6px;
		font-size: 12px;
		font-weight: 700;
		letter-spacing: 0.12em;
		text-transform: uppercase;
		color: rgba(255, 255, 255, 0.72);
	}

	.public-job-detail-list dd {
		margin: 0;
		font-size: 14px;
		line-height: 1.7;
	}

	.public-job-process {
		padding: 28px;
		border-radius: 30px;
		background: linear-gradient(180deg, rgba(238, 245, 251, 0.9) 0%, rgba(255, 255, 255, 0.98) 100%);
		border: 1px solid rgba(15, 61, 115, 0.08);
	}

	.public-job-process-head {
		margin-bottom: 18px;
	}

	.public-job-process-title {
		margin: 14px 0 0;
		font-size: 28px;
		font-weight: 700;
		color: var(--publicsite-primary-deep);
	}

	.public-job-steps {
		margin: 0;
		padding: 0;
		list-style: none;
		display: grid;
		grid-template-columns: repeat(3, minmax(0, 1fr));
		gap: 16px;
	}

	.public-job-steps li {
		padding: 20px;
		border-radius: 22px;
		background: #fff;
		border: 1px solid rgba(15, 61, 115, 0.08);
		box-shadow: 0 14px 24px rgba(15, 61, 115, 0.06);
	}

	.public-job-steps strong {
		display: block;
		margin-bottom: 10px;
		font-size: 16px;
		font-weight: 700;
		color: var(--publicsite-primary-deep);
	}

	.public-job-steps span {
		display: block;
		font-size: 14px;
		line-height: 1.75;
		color: var(--publicsite-muted);
	}

	@media (max-width: 860px) {
		.publicsite-site-header,
		.public_main_section,
		.publicsite-site-footer {
			padding-left: 16px;
			padding-right: 16px;
		}

		.publicsite-content {
			padding: 22px;
			border-radius: 24px;
		}

		.public-contact-hero {
			grid-template-columns: 1fr;
		}

		.public-job-hero,
		.public-job-grid,
		.public-job-steps {
			grid-template-columns: 1fr;
		}

		.publicsite-site-footer {
			flex-direction: column;
			align-items: flex-start;
		}
	}

	@media (max-width: 520px) {
		.publicsite-brand-name {
			font-size: 15px;
		}

		.publicsite-brand-overline {
			font-size: 10px;
		}

		.publicsite-brand-media,
		.publicsite-menu-toggle {
			width: 48px;
			height: 48px;
			border-radius: 16px;
		}

		.public-contact-title {
			font-size: 28px;
		}

		.public-contact-card,
		.public-contact-points li {
			padding-left: 18px;
			padding-right: 18px;
		}

		.public-job-panel,
		.public-job-process,
		.public-job-steps li,
		.public-job-visual-card {
			padding-left: 18px;
			padding-right: 18px;
		}

		.public-job-title {
			font-size: 30px;
		}
	}
</style>
