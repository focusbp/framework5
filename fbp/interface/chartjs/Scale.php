<?php

namespace chartjs;

/**
 * Interface Scale
 *
 * This interface defines the methods required for configuring scales in Chart.js.
 */
interface Scale {

    /**
     * Set the title of the scale.
     *
     * @param string $text The text to display as the scale's title.
     * @param bool $display Whether to display the title. Default is true.
     * @return void
     */
    public function set_title($text, $display = true);

    /**
     * Set the grid lines for the scale.
     *
     * @param bool $display Whether to display the grid lines. Default is true.
     * @param string $color The color of the grid lines. Default is 'rgba(0, 0, 0, 0.1)'.
     * @return void
     */
    public function set_gridLines($display = true, $color = 'rgba(0, 0, 0, 0.1)');

    /**
     * Set the ticks for the scale.
     *
     * @param bool $beginAtZero Whether the scale should start at zero. Default is true.
     * @param int|null $stepSize The step size between ticks. Default is null (automatic).
     * @return void
     */
    public function set_ticks($beginAtZero = true, $stepSize = null);

    /**
     * Set the minimum value for the scale.
     *
     * @param mixed $min The minimum value for the scale.
     * @return void
     */
    public function set_min($min);

    /**
     * Set the maximum value for the scale.
     *
     * @param mixed $max The maximum value for the scale.
     * @return void
     */
    public function set_max($max);

    /**
     * Set the time configuration for the scale (if it is a time-based scale).
     *
     * @param string $unit The unit of time (e.g., 'day', 'month'). Default is 'day'.
     * @param array $displayFormats An array of display formats for the time units. Default is an empty array.
     * @return void
     */
    public function set_time($unit = 'day', $displayFormats = []);

    /**
     * Add a custom option to the scale configuration.
     *
     * @param string $key The option key.
     * @param mixed $value The option value.
     * @return void
     */
    public function add_option($key, $value);

    /**
     * Convert the scale configuration to an array suitable for Chart.js.
     *
     * @return array An array representing the scale's configuration.
     */
    public function to_array();
}
