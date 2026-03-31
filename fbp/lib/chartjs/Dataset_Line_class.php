<?php

namespace chartjs;

class Dataset_Line_class extends Dataset_class implements Dataset_Line {
	private $fill;
	private $lineTension;
	private $borderDash;
	private $pointBackgroundColor;
	private $pointBorderColor;
	private $pointBorderWidth;
	private $pointRadius;
	private $pointHoverRadius;
	
	function __construct() {
		parent::__construct();
		$this->set_type("line");
	}

	function set_fill($fill = false) {
		$this->fill = $fill;
	}

	function set_lineTension($tension = 0.4) {
		$this->lineTension = $tension;
	}

	function set_borderDash(array $dash = []) {
		$this->borderDash = $dash;
	}

	function set_pointBackgroundColor($color = "rgba(0, 0, 0, 0.1)") {
		$this->pointBackgroundColor = $color;
	}

	function set_pointBorderColor($color = "rgba(0, 0, 0, 0.1)") {
		$this->pointBorderColor = $color;
	}

	function set_pointBorderWidth($width = 1) {
		$this->pointBorderWidth = $width;
	}

	function set_pointRadius($radius = 3) {
		$this->pointRadius = $radius;
	}

	function set_pointHoverRadius($radius = 5) {
		$this->pointHoverRadius = $radius;
	}

	function to_array() {
		return array_merge(parent::to_array(), [
			'fill' => $this->fill,
			'lineTension' => $this->lineTension,
			'borderDash' => $this->borderDash,
			'pointBackgroundColor' => $this->pointBackgroundColor,
			'pointBorderColor' => $this->pointBorderColor,
			'pointBorderWidth' => $this->pointBorderWidth,
			'pointRadius' => $this->pointRadius,
			'pointHoverRadius' => $this->pointHoverRadius,
		]);
	}
}
