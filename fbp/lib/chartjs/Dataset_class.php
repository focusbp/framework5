<?php

namespace chartjs;

class Dataset_class implements Dataset {
    private $label;
    private $data;
    private $backgroundColor;
    private $borderColor;
    private $borderWidth;
    private $hoverBackgroundColor;
    private $hoverBorderColor;
    private $hoverBorderWidth;
    private $type;  // タイプのプロパティを追加

    function __construct() {
    }

    function set_label($label) {
        $this->label = $label;
    }

    function set_data(array $data) {
        $this->data = $data;
    }

    function set_backgroundColor($color = "rgba(0, 0, 0, 0.1)") {
        $this->backgroundColor = $color;
    }

    function set_borderColor($color = "rgba(0, 0, 0, 0.1)") {
        $this->borderColor = $color;
    }

    function set_borderWidth($width = 1) {
        $this->borderWidth = $width;
    }

    function set_hoverBackgroundColor($color = "rgba(0, 0, 0, 0.1)") {
        $this->hoverBackgroundColor = $color;
    }

    function set_hoverBorderColor($color = "rgb(255, 159, 64)") {
        $this->hoverBorderColor = $color;
    }

    function set_hoverBorderWidth($width = 1) {
        $this->hoverBorderWidth = $width;
    }

    function set_type($type) {
        $this->type = $type;
    }

    function to_array() {
        return [
            'label' => $this->label,
            'data' => $this->data,
            'backgroundColor' => $this->backgroundColor,
            'borderColor' => $this->borderColor,
            'borderWidth' => $this->borderWidth,
            'hoverBackgroundColor' => $this->hoverBackgroundColor,
            'hoverBorderColor' => $this->hoverBorderColor,
            'hoverBorderWidth' => $this->hoverBorderWidth,
            'type' => $this->type  // タイプを配列に追加
        ];
    }
}
