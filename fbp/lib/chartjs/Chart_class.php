<?php

namespace chartjs;

class Chart_class implements Chart {

	private $type;
	private $labels = [];
	private $datasets = [];
	private $options = [];
	private $scales = [];

	function __construct() {
		
	}

	function set_type($type = "line") {
		$this->type = $type;
	}

	function set_labels(array $labels) {
		$this->labels = $labels;
	}

	function add_dataset(Dataset $dataset) {
		$this->datasets[] = $dataset;
	}

	function add_option($key, $value) {
		$this->options[$key] = $value;
	}

	function add_option_scales($key, Scale $scale) {
		$this->scales[$key] = $scale;
	}

	function to_array() {
		// Datasets を配列に変換
		$datasetsArray = array_map(function ($dataset) {
			return $dataset->to_array();
		}, $this->datasets);

		// Scales を配列に変換
		$scalesArray = [];
		foreach ($this->scales as $key => $scale) {
			$scalesArray[$key] = $scale->to_array();
		}

		// Chart.js の設定配列を構築
		$chartArray = [
		    'type' => $this->type,
		    'data' => [
			'labels' => $this->labels,
			'datasets' => $datasetsArray
		    ],
		    'options' => array_merge($this->options, ['scales' => $scalesArray])
		];

		return $chartArray;
	}

	// Dataset_Lineクラスのインスタンスを返す
	public function create_Dataset_Line(): Dataset_Line {
		return new Dataset_Line_class();
	}

	// Dataset_Barクラスのインスタンスを返す
	public function create_Dataset_Bar(): Dataset_Bar {
		return new Dataset_Bar_class();
	}

	// Dataset_Bubbleクラスのインスタンスを返す
	public function create_Dataset_Bubble(): Dataset_Bubble {
		return new Dataset_Bubble_class();
	}

	// Dataset_Pieクラスのインスタンスを返す
	public function create_Dataset_Pie(): Dataset_Pie {
		return new Dataset_Pie_class();
	}

	// Dataset_PolarAreaクラスのインスタンスを返す
	public function create_Dataset_PolarArea(): Dataset_PolarArea {
		return new Dataset_PolarArea_class();
	}

	// Dataset_Radarクラスのインスタンスを返す
	public function create_Dataset_Radar(): Dataset_Radar {
		return new Dataset_Radar_class();
	}

	// Dataset_Scatterクラスのインスタンスを返す
	public function create_Dataset_Scatter(): Dataset_Scatter {
		return new Dataset_Scatter_class();
	}
	
	public function create_Dataset_Doughnut(): Dataset_Doughnut {
		return new Dataset_Doughnut_class();
	}

	// Scaleクラスのインスタンスを返す
	public function create_Scale(string $id, string $type, string $position): Scale {
		return new Scale_class($id, $type, $position);
	}
}
