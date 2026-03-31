<?php

namespace chartjs;

/**
 * Interface Dataset_Scatter
 *
 * This interface extends the Dataset interface and adds specific methods for configuring scatter chart datasets in Chart.js.
 */
interface Dataset_Scatter extends Dataset {

    /**
     * Set whether to show a line connecting the points in the scatter chart.
     *
     * @param bool $showLine Whether to show a line connecting the points. Default is false.
     * @return void
     */
    public function set_showLine($showLine = false);

    /**
     * Set whether to span gaps in the data with a line in the scatter chart.
     *
     * @param bool $spanGaps Whether to span gaps in the data. Default is false.
     * @return void
     */
    public function set_spanGaps($spanGaps = false);
}
