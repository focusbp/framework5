<?php

namespace chartjs;

/**
 * Interface Dataset_PolarArea
 *
 * This interface extends the Dataset interface and adds specific methods for configuring polar area chart datasets in Chart.js.
 */
interface Dataset_PolarArea extends Dataset {

    /**
     * Set the radius of the segments when hovered in the polar area chart.
     *
     * @param int $radius The radius in pixels of the segments when hovered. Default is 5 pixels.
     * @return void
     */
    public function set_hoverRadius($radius = 5);

    /**
     * Set the border color of the segments when hovered in the polar area chart.
     *
     * @param string $color The color of the border when hovered. Default is "rgb(255, 159, 64)".
     * @return void
     */
    public function set_hoverBorderColor($color = "rgb(255, 159, 64)");

    /**
     * Set the border width of the segments when hovered in the polar area chart.
     *
     * @param int $width The width of the border in pixels when hovered. Default is 1 pixel.
     * @return void
     */
    public function set_hoverBorderWidth($width = 1);
}
