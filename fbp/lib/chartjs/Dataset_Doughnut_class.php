<?php

namespace chartjs;

class Dataset_Doughnut_class extends Dataset_class implements Dataset_Doughnut {

    function __construct() {
        parent::__construct();
        $this->set_type("doughnut");
    }

    // Doughnut特有のメソッドがあればここに追加します
}