<form id="form_{$timestamp}">


	<div>
		<p class="lang">Title (Short name for this job)</p>
		<input type="text" name="title" value="{$post.title}">
	</div>

	<div>
		<p class="lang">Class Name</p>
		<input type="text" name="class_name" value="{$post.class_name}">
	</div>

	<div>
		<p class="lang">Handler Function</p>
		<input type="text" name="function_name" value="{$post.function_name}">
	</div>

	<div>
		<button class="ajax-link lang" data-form="form_{$timestamp}" data-class="{$class}" data-function="add_exe">Add</button>
	</div>
</form>
