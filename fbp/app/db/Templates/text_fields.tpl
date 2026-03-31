
<div>
	<p>{$db.tb_name} / {$db.menu_name}</p>
	<p>&nbsp;</p>
	<p>
{foreach $field_list as $f}
	{$f.parameter_name} / {$f.parameter_title} / {$f.type} / {if $f.constant_array_name != ""}option_name:{$f.constant_array_name}{/if}<br />
{/foreach}
	</p>
</div>
