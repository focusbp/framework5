<?php

namespace chartjs;

class Dataset_Pie_class extends Dataset_class implements Dataset_Pie {
	private $weight;
	private $hoverOffset;
	
	function __construct() {
		parent::__construct();
		$this->set_type("pie");
	}

	function set_weight($weight = 1) {
		$this->weight = $weight;
	}

	function set_hoverOffset($offset = 4) {
		$this->hoverOffset = $offset;
	}

	function to_array() {
		return array_merge(parent::to_array(), [
			'weight' => $this->weight,
			'hoverOffset' => $this->hoverOffset,
		]);
	}
}
