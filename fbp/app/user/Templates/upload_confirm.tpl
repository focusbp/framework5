
<div>
	<table>
		<tr>
			<td class="status"></td>
			<td class="lang">Name</td>
			<td class="lang">Email</td>
			<td class="lang">Passsword</td>
		</tr>
		{foreach $list as $row}
			<tr>
				{if count($row.errors) == 0}
					<td>OK</td>
				{else}
					<td>
						{foreach $row.errors as $e}
							<p class="error">{$e}</p>
						{/foreach}
					</td>
				{/if}
				<td>{$row.name}</td>
				<td>{$row.email}</td>
				<td>{$row.password}</td>
			</tr>
		{/foreach}

	</table>
	
</div>


<div>
	{if $next_flg}
	<button class="ajax-link lang" data-class="{$class}" data-function="upload_csv_exe">Add</button>
	{else}
		<p class="error">There are errors, please fix it first.</p>
	{/if}
</div>


