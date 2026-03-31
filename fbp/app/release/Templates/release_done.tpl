
{if $success }
	<p>{$success}</p>
	<button class="ajax-link" data-class="{$class}" data-function="reload">Reload this browser</button>
{/if}

{if $fail }
	<p class="error">{$fail}</p>
{/if}

