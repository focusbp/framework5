
<form>
<table>
	<tr>
		<th style="width:30%;text-align: left;">Class</th>
		<th style="width:30%;text-align: left;">English</th>
		<th style="width:30%;text-align: left;">Japanese</th>
		<th style="width:10%;"></th>
	</tr>

	{foreach $arr as $d}
		<tr>
			<td>{$d.classname}</td>
			<td>{$d.en}</td>
			<td><input type="text" class="lang_change" value="{$d.jp}" data-classname="{$d.classname}" data-en="{$d.en}"></td>
		</tr>
	{/foreach}

</table>

</form>
	
<script>
	$(".lang_change").on("change", function () {
		var url = "app.php";
		var fd = new FormData();
		fd.append("class", "lang");
		fd.append("function", "update");
		fd.append("classname", $(this).data("classname"));
		fd.append("en", $(this).data("en"));
		fd.append("jp", $(this).val());
		appcon(url, fd, function (e) {
			get_lang_list();
		});
	});

</script>