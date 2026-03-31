<?php

namespace chartjs;

class Dataset_Bar_class extends Dataset_class implements Dataset_Bar {
	
	private $barThickness;
	private $maxBarThickness;
	private $minBarLength;
	private $categoryPercentage;
	private $barPercentage;

	function __construct() {
		parent::__construct();
		$this->set_type("bar");
	}

	function set_barThickness($thickness = null) {
		$this->barThickness = $thickness;
	}

	function set_maxBarThickness($thickness = null) {
		$this->maxBarThickness = $thickness;
	}

	function set_minBarLength($length = 2) {
		$this->minBarLength = $length;
	}

	function set_categoryPercentage($percentage = 0.8) {
		$this->categoryPercentage = $percentage;
	}

	function set_barPercentage($percentage = 0.9) {
		$this->barPercentage = $percentage;
	}

	function to_array() {
		return array_merge(parent::to_array(), [
		    'barThickness' => $this->barThickness,
		    'maxBarThickness' => $this->maxBarThickness,
		    'minBarLength' => $this->minBarLength,
		    'categoryPercentage' => $this->categoryPercentage,
		    'barPercentage' => $this->barPercentage,
		]);
	}
}
