<?php

namespace chartjs;

class Dataset_PolarArea_class extends Dataset_class implements Dataset_PolarArea{
	private $hoverRadius;
	private $hoverBorderColor;
	private $hoverBorderWidth;
	
	function __construct() {
		parent::__construct();
		$this->set_type("polarArea");
	}

	function set_hoverRadius($radius = 5) {
		$this->hoverRadius = $radius;
	}

	function set_hoverBorderColor($color = "rgb(255, 159, 64)") {
		$this->hoverBorderColor = $color;
	}

	function set_hoverBorderWidth($width = 1) {
		$this->hoverBorderWidth = $width;
	}

	function to_array() {
		return array_merge(parent::to_array(), [
			'hoverRadius' => $this->hoverRadius,
			'hoverBorderColor' => $this->hoverBorderColor,
			'hoverBorderWidth' => $this->hoverBorderWidth,
		]);
	}
}