
<!--<button class="ajax-link" data-class="lang" data-function="all_clear" style="float: right;">Clear All</button>-->
<!--<button class="ajax-link" data-class="lang" data-function="blank_clear" style="float: right;">Clear Blank</button>-->
<div style="margin-top: 10px;">
	<button class="ajax-link" data-class="lang" data-function="add">Add</button>
</div>
<div style="margin-top: 10px;">
	<form id="lang_search_form" style="width: 100%; display: flex; ">
		<div style="width: 200px;">
			<input type="text" name="lang_search" value="{$MYSESSION.lang_search}">
		</div>
		<div>
			<button class="ajax-link" data-class="lang" data-function="search" data-form="lang_search_form" style="float: left;margin-top:1px;">Search</button>
		</div>
	</form>
</div>

<div style="clear:both; border-bottom:1px #ccc solid; width:100%; padding-top:20px;"></div>

<table>
	<tr>
		<th style="width:30%;text-align: left;">Class</th>
		<th style="width:30%;text-align: left;">English</th>
		<th style="width:30%;text-align: left;">Japanese</th>
		<th style="width:10%;"></th>
	</tr>

	{foreach $list as $d}
		<tr>
			<td>{$d.classname}</td>
			<td>{$d.en}</td>
			<td><input type="text" class="lang_change" data-id="{$d.id}" value="{$d.jp}"></td>
			<td><span class="ajax-link" data-class="lang" data-function="delete" data-id="{$d.id}" style="cursor: pointer"><span class="ui-icon ui-icon-trash"></span></span></td>
		</tr>
	{/foreach}

</table>
	
{if $is_last == false}
	<div class="ajax-auto" data-class="{$class}" data-function="showlist" data-max="{$max}">{$max}</div>
{/if}

<script>
	$(".lang_change").on("change", function () {
		var val = $(this).val();
		var url = "app.php";
		var fd = new FormData();
		fd.append("class", "lang");
		fd.append("function", "edit_exe");
		fd.append("id", $(this).data("id"));
		fd.append("jp", val);
		appcon(url, fd, function (e) {
			get_lang_list();
		});
	});

</script>
