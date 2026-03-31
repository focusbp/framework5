<?php


namespace chartjs;

class Dataset_Scatter_class extends Dataset_class implements Dataset_Scatter{
	private $showLine;
	private $spanGaps;
	
	function __construct() {
		parent::__construct();
		$this->set_type("scatter");
	}

	function set_showLine($showLine = false) {
		$this->showLine = $showLine;
	}

	function set_spanGaps($spanGaps = false) {
		$this->spanGaps = $spanGaps;
	}

	function to_array() {
		return array_merge(parent::to_array(), [
			'showLine' => $this->showLine,
			'spanGaps' => $this->spanGaps,
		]);
	}
}
