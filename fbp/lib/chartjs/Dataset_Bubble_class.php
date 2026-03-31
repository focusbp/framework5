<?php

namespace chartjs;

class Dataset_Bubble_class extends Dataset_class implements Dataset_Bubble {
	private $radius;
	private $hoverRadius;
	private $hitRadius;
	
	function __construct() {
		parent::__construct();
		$this->set_type("bubble");
	}

	function set_radius($radius = 10) {
		$this->radius = $radius;
	}

	function set_hoverRadius($hoverRadius = 12) {
		$this->hoverRadius = $hoverRadius;
	}

	function set_hitRadius($hitRadius = 5) {
		$this->hitRadius = $hitRadius;
	}

	function to_array() {
		return array_merge(parent::to_array(), [
			'radius' => $this->radius,
			'hoverRadius' => $this->hoverRadius,
			'hitRadius' => $this->hitRadius,
		]);
	}
}
