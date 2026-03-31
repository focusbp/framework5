<?php


namespace chartjs;

class Dataset_Radar_class extends Dataset_class implements Dataset_Radar{
	private $pointStyle;
	private $hitRadius;
	private $radius;
	private $pointBackgroundColor;
	
	function __construct() {
		parent::__construct();
		$this->set_type("radar");
	}

	function set_pointStyle($style = 'circle') {
		$this->pointStyle = $style;
	}

	function set_hitRadius($radius = 1) {
		$this->hitRadius = $radius;
	}

	function set_radius($radius = 3) {
		$this->radius = $radius;
	}
	
	function set_pointBackgroundColor($color = "rgb(255, 159, 64)"){
		$this->pointBackgroundColor = $color;
	}


	function to_array() {
		return array_merge(parent::to_array(), [
			'pointStyle' => $this->pointStyle,
			'hitRadius' => $this->hitRadius,
			'radius' => $this->radius,
			'pointBackgroundColor' => $this->pointBackgroundColor
		]);
	}
}