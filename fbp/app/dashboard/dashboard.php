<?php

class dashboard {

	private $column_width_opt = [
	    1 => "1 column",
	    2 => "2 columns",
	    3 => "3 columns"
	];

	function __construct(Controller $ctl) {
		$ctl->assign("column_width_opt", $this->column_width_opt);
	}

	function list(Controller $ctl) {
		$items = $ctl->db("dashboard")->getall("sort", SORT_ASC);
		$ctl->assign("items", $items);
		$ctl->reload_area("#tabs-dashboard", "list.tpl");
	}

	function add(Controller $ctl) {
		$post = [
		    "function_name" => "dashboard",
		    "column_width" => 1
		];
		$ctl->assign("post", $post);
		$ctl->show_multi_dialog("dashboard_add", "add.tpl", "Add Dashboard Widget", 700, true, true);
	}

	function add_exe(Controller $ctl) {
		$post = $ctl->POST();
		$save = $this->validate_and_build($ctl, $post);
		if ($ctl->count_res_error_message() > 0) {
			return;
		}

		$ctl->db("dashboard")->insert($save);
		$save["sort"] = (int)($save["id"] ?? 0);
		$ctl->db("dashboard")->update($save);

		$ctl->close_multi_dialog("dashboard_add");
		$ctl->invoke("list");
		$ctl->reload_menu();
	}

	function edit(Controller $ctl) {
		$id = (int)$ctl->POST("id");
		$data = $ctl->db("dashboard")->get($id);
		$ctl->assign("post", $data);
		$ctl->show_multi_dialog("dashboard_edit", "edit.tpl", "Edit Dashboard Widget", 700, true, true);
	}

	function edit_exe(Controller $ctl) {
		$post = $ctl->POST();
		$current = $ctl->db("dashboard")->get((int)$post["id"]);
		$save = $this->validate_and_build($ctl, $post, $current);
		if ($ctl->count_res_error_message() > 0) {
			return;
		}

		$ctl->db("dashboard")->update($save);
		$ctl->close_multi_dialog("dashboard_edit");
		$ctl->invoke("list");
	}

	function delete(Controller $ctl) {
		$id = (int)$ctl->POST("id");
		$data = $ctl->db("dashboard")->get($id);
		$ctl->assign("data", $data);
		$ctl->show_multi_dialog("dashboard_delete", "delete.tpl", "Delete Dashboard Widget", 500, true, true);
	}

	function delete_exe(Controller $ctl) {
		$id = (int)$ctl->POST("id");
		$ctl->db("dashboard")->delete($id);
		$ctl->close_multi_dialog("dashboard_delete");
		$ctl->close_multi_dialog("dashboard_edit");
		$ctl->invoke("list");
		$ctl->reload_menu();
	}

	function sort(Controller $ctl) {
		$log = (string)$ctl->POST("log");
		$ids = array_filter(explode(',', $log), 'strlen');
		$c = 1;
		foreach ($ids as $id) {
			$row = $ctl->db("dashboard")->get((int)$id);
			$row["sort"] = $c;
			$ctl->db("dashboard")->update($row);
			$c++;
		}
	}

	function page(Controller $ctl) {
		$widget_db = $ctl->db("dashboard");
		$widgets = $widget_db->getall("sort", SORT_ASC);

		$ctl->reset_dashbord_items();

		foreach ($widgets as $widget) {
			$class_name = trim((string)($widget["class_name"] ?? ""));
			$function_name = trim((string)($widget["function_name"] ?? ""));
			$column_width = (int)($widget["column_width"] ?? 1);

			if (!preg_match('/^[A-Za-z][A-Za-z0-9_-]*$/', $class_name)) {
				$ctl->res_error_message("dashboard", "Invalid class_name in dashboard id=" . (int)$widget["id"]);
				return;
			}
			if (!preg_match('/^[A-Za-z][A-Za-z0-9_]*$/', $function_name)) {
				$ctl->res_error_message("dashboard", "Invalid function_name in dashboard id=" . (int)$widget["id"]);
				return;
			}
			if ($column_width < 1 || $column_width > 3) {
				$ctl->res_error_message("dashboard", "column_width must be 1-3 in dashboard id=" . (int)$widget["id"]);
				return;
			}
			if ($class_name === "dashboard" && $function_name === "page") {
				$ctl->res_error_message("dashboard", "dashboard/page cannot be used as a widget.");
				return;
			}

			$this->invoke_widget($ctl, $class_name, $function_name, $column_width);
			if ($ctl->count_res_error_message() > 0) {
				return;
			}
		}

		$rows = $this->build_rows($ctl->get_dashbord_items());
		$ctl->assign("dashboard_rows", $rows);
		$ctl->assign("dashboard_empty", count($rows) === 0);
		$ctl->show_main_area("index.tpl", "Dashboard");
	}

	private function validate_and_build(Controller $ctl, array $post, array $current = null): array {
		$class_name = trim((string)($post["class_name"] ?? ""));
		$function_name = trim((string)($post["function_name"] ?? ""));
		$column_width = (int)($post["column_width"] ?? 1);

		if (!preg_match('/^[A-Za-z][A-Za-z0-9_-]*$/', $class_name)) {
			$ctl->res_error_message("class_name", "Use letters, numbers, hyphens (-), or underscores (_). Start with a letter.");
			return [];
		}
		if (!preg_match('/^[A-Za-z][A-Za-z0-9_]*$/', $function_name)) {
			$ctl->res_error_message("function_name", "Use letters, numbers, or underscores (_). Start with a letter.");
			return [];
		}
		if ($column_width < 1 || $column_width > 3) {
			$ctl->res_error_message("column_width", "Select 1 to 3.");
			return [];
		}

		$save = $current ?? [];
		$save["class_name"] = $class_name;
		$save["function_name"] = $function_name;
		$save["column_width"] = $column_width;
		$save["sort"] = (int)($save["sort"] ?? 0);

		return $save;
	}

	private function invoke_widget(Controller $ctl, string $class_name, string $function_name, int $column_width): void {
		$widget = $this->get_class_object($ctl, $class_name);
		if ($widget == null) {
			$ctl->res_error_message("dashboard", "Widget class not found: " . $class_name);
			return;
		}
		if (!method_exists($widget, $function_name)) {
			$ctl->res_error_message("dashboard", "Widget function not found: " . $class_name . "/" . $function_name);
			return;
		}

		$before_count = count($ctl->get_dashbord_items());
		$current_class = $ctl->get_classname();
		$ctl->set_dashbord_column_width($column_width);
		try {
			$ctl->set_class($class_name);
			$widget->$function_name($ctl);
		} finally {
			$ctl->set_class($current_class);
			$ctl->set_dashbord_column_width(1);
		}

		if (count($ctl->get_dashbord_items()) === $before_count) {
			$ctl->res_error_message("dashboard", "Widget did not call show_dashboard_widget(): " . $class_name . "/" . $function_name);
		}
	}

	private function get_class_object(Controller $ctl, string $class_name) {
		$dir = new Dirs();
		try {
			$classfile = $dir->get_class_dir($class_name) . "/" . $class_name . ".php";
		} catch (Exception $e) {
			return null;
		}
		if (!is_file($classfile)) {
			return null;
		}
		include_once($classfile);
		if (!class_exists($class_name)) {
			return null;
		}

		$reflectionClass = new ReflectionClass($class_name);
		$constructor = $reflectionClass->getConstructor();
		if ($constructor && count($constructor->getParameters()) > 0) {
			return new $class_name($ctl);
		}
		return new $class_name;
	}

	private function build_rows(array $items): array {
		$rows = [];
		$current_row = [];
		$current_width = 0;

		foreach ($items as $item) {
			$w = (int)$item["column_width"];
			if ($current_width + $w > 3) {
				if (count($current_row) > 0) {
					$rows[] = $current_row;
				}
				$current_row = [];
				$current_width = 0;
			}
			$current_row[] = $item;
			$current_width += $w;
			if ($current_width === 3) {
				$rows[] = $current_row;
				$current_row = [];
				$current_width = 0;
			}
		}

		if (count($current_row) > 0) {
			$rows[] = $current_row;
		}

		return $rows;
	}
}
