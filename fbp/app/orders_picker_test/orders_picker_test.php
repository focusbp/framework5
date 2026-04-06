<?php

class orders_picker_test {
	private $dialog_name = "orders_picker_test_dialog";

	public function run(Controller $ctl) {
		$ctl->show_multi_dialog($this->dialog_name, "dialog.tpl", "Orders Picker Test", 760);
	}

	public function close_dialog(Controller $ctl) {
		$ctl->close_multi_dialog($this->dialog_name);
	}
}
