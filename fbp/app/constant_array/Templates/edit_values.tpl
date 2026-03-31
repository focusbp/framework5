<form id="form_edit_values{$values.id}">
    Value(ID): <input type="text" name="key" value="{$values.key}">
    <p class="error">{$errors['key']}</p>

    Label: <input type="text" name="value" value="{$values.value}">
    <p class="error">{$errors['value']}</p>

    Color: <input type="text" name="color" value="{$values.color}" class="colorpicker">
    <p class="error">{$errors['color']}</p>
    <button class="ajax-link" data-form="form_edit_values{$values.id}" data-class="{$class}" data-function="edit_values_exe" data-id="{$values.id}" data-constant_array_id="{$constant_array_id}">Update</button>

</form>

