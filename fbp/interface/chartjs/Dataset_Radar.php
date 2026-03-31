<?php

namespace chartjs;

/**
 * Interface Dataset_Radar
 *
 * This interface extends the Dataset interface and adds specific methods for configuring radar chart datasets in Chart.js.
 */
interface Dataset_Radar extends Dataset {

    /**
     * Set the style of the points in the radar chart.
     *
     * @param string $style The style of the points (e.g., 'circle', 'rect', 'triangle'). Default is 'circle'.
     * @return void
     */
    public function set_pointStyle($style = 'circle');

    /**
     * Set the radius of the hit area around the points in the radar chart.
     *
     * @param int $radius The radius in pixels of the hit area around each point. Default is 1 pixel.
     * @return void
     */
    public function set_hitRadius($radius = 1);

    /**
     * Set the radius of the points in the radar chart.
     *
     * @param int $radius The radius in pixels of the points. Default is 3 pixels.
     * @return void
     */
    public function set_radius($radius = 3);

    /**
     * Set the background color of the points in the radar chart.
     *
     * @param string $color The background color of the points (e.g., 'rgb(255, 159, 64)'). Default is 'rgb(255, 159, 64)'.
     * @return void
     */
    public function set_pointBackgroundColor($color = "rgb(255, 159, 64)");
}
