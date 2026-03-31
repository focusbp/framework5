<?php

namespace chartjs;

interface Dataset_Line extends Dataset {
    public function set_fill($fill = false);
    public function set_lineTension($tension = 0.4);
    public function set_borderDash(array $dash = []);
    public function set_pointBackgroundColor($color = "rgba(0, 0, 0, 0.1)");
    public function set_pointBorderColor($color = "rgba(0, 0, 0, 0.1)");
    public function set_pointBorderWidth($width = 1);
    public function set_pointRadius($radius = 3);
    public function set_pointHoverRadius($radius = 5);
}
