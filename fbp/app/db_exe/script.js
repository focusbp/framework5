
var isOverSortable = false;

append_function_dialog(function(dialog_id){
	
	$(".calendar_box").each(function() {
		if ($(this).hasClass("ui-sortable")) {
		  $(this).sortable("destroy");
		}

		$(this).sortable({
			handle: ".handle",
			items: ".task",
			cancel: ".ajax-link",
			connectWith: ".calendar_box, .unassigned_tasks",
			tolerance: "pointer",
			revert: 200,
			stop: function(event, ui) {
				// connectWith 以外にドロップされた場合
				if (ui.item.closest(".calendar_box").length === 0) {
					$(ui.item).appendTo(ui.sender);
					$(ui.sender).sortable('cancel');
				}
				ui.item.removeClass("dragging");
			},
			start: function (event, ui) {
				ui.placeholder.height(ui.helper.outerHeight());
				isOverSortable=false;
				ui.item.addClass("dragging");
			},
			update: function (event, ui) {

				if (!isOverSortable) {
					$(ui.item).appendTo(ui.sender);
					$(ui.sender).sortable('cancel');
					return;
				}

				var log = $(this).sortable("toArray");
				var fd = new FormData();

				// ドロップ先の calendar_box の情報を取得
				var targetCalendarBox = ui.item.closest('.calendar_box');

				// ドラッグした task の情報を取得
				var task = ui.item;

				fd.append("class", task.data("class"));
				fd.append("db_id", task.data("db_id"));
				fd.append("function", "edit_datetime_exe");
				fd.append("id", task.data("id"));
				fd.append("datetime",targetCalendarBox.data("datetime"));
				appcon("app.php", fd,function(){
				});
			},
			over: function (event, ui) {
				$(this).css("background-color", "#f0f8ff");  // 背景色を変更
				isOverSortable=true;
			},
			out: function (event, ui) {
				$(this).css("background-color", "#FFF");  // 背景色を元に戻す
				isOverSortable=false;
			}
		});
	
	});
	
});