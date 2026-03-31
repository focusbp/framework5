<?php

namespace chartjs;

class Scale_class implements Scale {
    protected $id;
    protected $type;
    protected $position;
    protected $display;
    protected $title;
    protected $gridLines;
    protected $ticks;
    protected $min;
    protected $max;
    protected $time;
    protected $additionalOptions = [];  // 追加オプション用の配列
    protected $beginAtZero;

    function __construct($id = 'y-axis-1', $type = 'linear', $position = 'left', $display = true) {
        $this->id = $id;
        $this->type = $type;
        $this->position = $position;
        $this->display = $display;
    }

    function set_title($text, $display = true) {
        $this->title = [
            'display' => $display,
            'text' => $text,
        ];
    }

    function set_gridLines($display = true, $color = 'rgba(0, 0, 0, 0.1)') {
        $this->gridLines = [
            'display' => $display,
            'color' => $color,
        ];
    }

    function set_ticks($beginAtZero = true, $stepSize = null) {
	$this->beginAtZero = $beginAtZero;
        $this->ticks = [
            'stepSize' => $stepSize,
        ];
    }

    function set_min($min) {
        $this->min = $min;
    }

    function set_max($max) {
        $this->max = $max;
    }

    function set_time($unit = 'day', $displayFormats = []) {
        if ($this->type === 'time') {
            $this->time = [
                'unit' => $unit,
                'displayFormats' => $displayFormats,
            ];
        }
    }

    public function add_option($key, $value) {
        $this->additionalOptions[$key] = $value;
    }

    function to_array() {
        $scaleArray = [
            'id' => $this->id,
            'type' => $this->type,
            'position' => $this->position,
            'display' => $this->display,
            'title' => $this->title,
            'gridLines' => $this->gridLines,
            'ticks' => $this->ticks,
            'min' => $this->min,
            'max' => $this->max,
	    'beginAtZero' => $this->beginAtZero,
        ];

        if ($this->type === 'time' && $this->time) {
            $scaleArray['time'] = $this->time;
        }

        // 追加オプションをマージ
        $scaleArray = array_merge($scaleArray, $this->additionalOptions);

        return $scaleArray;
    }
}