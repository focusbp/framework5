<div style="display: block;overflow: hidden;">
	<form>

		<div class="form-row">
			<p class="lang" style="font-weight:bold;">Button Title</p>
			<p style="font-size:14px;margin-top:0px;">You can choose either text or an icon for the button type.
				If you choose the icon type, enter the <a href="https://fonts.google.com/icons" target="_blank">Google Material icon name</a>(for example, "Search", "Arrow Upward") in the Title text box.</p>
			<div style="display: flex;">
				{html_options name="button_type" options=$button_type_opt selected=$post.button_type style="width:300px;"}
			<input type="text" name="button_title" value="{$post.button_title}">
			</div>
			<p class="error_message error_button_title"></p>
		</div>


		<div class="form-row">
			<p class="lang" style="font-weight:bold;">Action Name</p>
			<p style="margin-top:0px;">Internal name used for the action (letters, numbers, _ only) Example: customer_add</p>
			<input type="text" name="class_name" value="{$post.class_name}">
			<p class="error_message error_class_name"></p>
		</div>
		
		<div class="form-row">
			<p class="lang" style="font-weight:bold;">Function Name</p>
			<p style="margin-top:0px;">Internal function name (letters, numbers, _ only) Example: run</p>
			<input type="text" name="function_name" value="{$post.function_name|default:'run'}">
			<p class="error_message error_function_name"></p>
		</div>

		<div class="form-row">
			<p class="lang" style="font-weight:bold;">Place:</p>
			<div style="display:flex; gap:10px;">
			  <div style="width:50%;">
				  {html_options name="tb_name" options=$database_names selected=$post["tb_name"]}
			  </div>

			  <div style="width:50%;">
				  {html_options name="place" options=$place_opt selected=$post["place"]}
			  </div>
			</div>
			<p class="error_message error_place lang">{$errors['place']}</p>
		</div>



		<div style="margin-top:5px;">

			<button type="button"
					class="ajax-link lang"
					invoke-function="add_exe"
					data-flg="save_only"
					data-reflesh_db="{$reflesh_db}"
					>
			  Save
			</button>
		</div>

	</form>


</div>
				
