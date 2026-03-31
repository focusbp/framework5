<form id="form_add_values{$constant_array_id}">
    <input type="hidden" name="constant_array_id" value="{$constant_array_id}">
    Value(ID): <input type="text" name="key" value="{$data.key}">
    <p class="error">{$errors['key']}</p>

    Label: <input type="text" name="value" value="{$data.value}">
    <p class="error">{$errors['value']}</p>

    Color: <input type="text" name="color" value="{$data.color}" class="colorpicker">
    <p class="error">{$errors['color']}</p>

    <button data-constant_array_id="{$constant_array_id}" class="ajax-link" data-form="form_add_values{$constant_array_id}" data-class="{$class}" data-function="insert_values">Add</button>

</form>
