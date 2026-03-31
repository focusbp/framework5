<form id="upload_csv_form">
	
        <p class="lang">Choose a CSV File</p>
	<input type="file" name="users_csv" class="fr_image_paste">
	<p class="error lang">{$errors['users_csv']}</p>
	<p class="lang">CSV Format : First line is title. Columns are Name,Email.</p>
	<img src="app.php?class={$class}&function=image_sample" style="width:40%">
	
	<p class="lang">Character Code</p>
	{html_options name="code" options=$code_list selected=$post.code}

	<button class="ajax-link lang" data-form="upload_csv_form" data-class="{$class}" data-function="upload_csv_confirm">Update</button>
	
	<div style="height:100px;"></div>
</form>

