<?php

namespace chartjs;

/**
 * Interface Dataset_Bar
 *
 * This interface extends the Dataset interface and adds specific methods for configuring bar chart datasets in Chart.js.
 */
interface Dataset_Bar extends Dataset {

    /**
     * Set the bar thickness for the dataset.
     *
     * @param int|null $thickness The thickness of the bars in pixels. Default is null, which lets Chart.js automatically calculate the bar thickness.
     * @return void
     */
    public function set_barThickness($thickness = null);

    /**
     * Set the maximum bar thickness for the dataset.
     *
     * @param int|null $thickness The maximum thickness of the bars in pixels. Default is null.
     * @return void
     */
    public function set_maxBarThickness($thickness = null);

    /**
     * Set the minimum bar length for the dataset.
     *
     * @param int $length The minimum length of the bars in pixels. Default is 2 pixels.
     * @return void
     */
    public function set_minBarLength($length = 2);

    /**
     * Set the category percentage for the dataset.
     *
     * @param float $percentage The percentage of the available width each category should occupy. Default is 0.8.
     * @return void
     */
    public function set_categoryPercentage($percentage = 0.8);

    /**
     * Set the bar percentage for the dataset.
     *
     * @param float $percentage The percentage of the available width each bar should occupy within its category. Default is 0.9.
     * @return void
     */
    public function set_barPercentage($percentage = 0.9);
}
