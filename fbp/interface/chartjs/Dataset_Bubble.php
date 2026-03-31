<?php

namespace chartjs;

/**
 * Interface Dataset_Bubble
 *
 * This interface extends the Dataset interface and adds specific methods for configuring bubble chart datasets in Chart.js.
 */
interface Dataset_Bubble extends Dataset {

    /**
     * Set the radius of the bubbles in the dataset.
     *
     * @param int $radius The radius of the bubbles in pixels. Default is 10 pixels.
     * @return void
     */
    public function set_radius($radius = 10);

    /**
     * Set the radius of the bubbles when hovered.
     *
     * @param int $hoverRadius The radius of the bubbles in pixels when hovered. Default is 12 pixels.
     * @return void
     */
    public function set_hoverRadius($hoverRadius = 12);

    /**
     * Set the hit radius of the bubbles in the dataset.
     *
     * @param int $hitRadius The additional radius in pixels around the bubbles for hit detection. Default is 5 pixels.
     * @return void
     */
    public function set_hitRadius($hitRadius = 5);
}
