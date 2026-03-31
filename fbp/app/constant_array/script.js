append_function_dialog(function(dialog_id){


    $(dialog_id+".sort").sortable({
        handle:".handle",
        cancel:".buttons",
		axis:"y",
        update: function(){
            var log = $(this).sortable("toArray");
            var fd = new FormData();
            fd.append("class","constant_array");
            fd.append("function","sort");
            fd.append("log",log);
            appcon("app.php", fd);
        }
    });

});


