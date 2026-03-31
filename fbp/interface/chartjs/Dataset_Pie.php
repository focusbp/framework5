<?php

namespace chartjs;

interface Dataset_Pie extends Dataset {
    public function set_weight($weight = 1);
    public function set_hoverOffset($offset = 4);
}
