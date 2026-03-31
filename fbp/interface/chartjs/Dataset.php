<?php

namespace chartjs;

/**
 * Interface Dataset
 *
 * This interface defines the methods required for creating and configuring a dataset in Chart.js.
 */
interface Dataset {

    /**
     * Set the label for the dataset.
     *
     * @param string $label The label for the dataset.
     * @return void
     */
    public function set_label($label);

    /**
     * Set the data for the dataset.
     *
     * @param array $data An array of data points for the dataset.
     * @return void
     */
    public function set_data(array $data);

    /**
     * Set the background color for the dataset.
     *
     * @param string $color The background color (e.g., 'rgba(0, 0, 0, 0.1)').
     * @return void
     */
    public function set_backgroundColor($color = "rgba(0, 0, 0, 0.1)");

    /**
     * Set the border color for the dataset.
     *
     * @param string $color The border color (e.g., 'rgba(0, 0, 0, 0.1)').
     * @return void
     */
    public function set_borderColor($color = "rgba(0, 0, 0, 0.1)");

    /**
     * Set the border width for the dataset.
     *
     * @param int $width The border width in pixels.
     * @return void
     */
    public function set_borderWidth($width = 1);

    /**
     * Set the hover background color for the dataset.
     *
     * @param string $color The hover background color (e.g., 'rgba(0, 0, 0, 0.1)').
     * @return void
     */
    public function set_hoverBackgroundColor($color = "rgba(0, 0, 0, 0.1)");

    /**
     * Set the hover border color for the dataset.
     *
     * @param string $color The hover border color (e.g., 'rgb(255, 159, 64)').
     * @return void
     */
    public function set_hoverBorderColor($color = "rgb(255, 159, 64)");

    /**
     * Set the hover border width for the dataset.
     *
     * @param int $width The hover border width in pixels.
     * @return void
     */
    public function set_hoverBorderWidth($width = 1);

    /**
     * Set the type of the dataset (e.g., 'line', 'bar').
     *
     * @param string $type The type of the dataset.
     * @return void
     */
    public function set_type($type);

    /**
     * Convert the dataset configuration to an array suitable for Chart.js.
     *
     * @return array An array representing the dataset's configuration.
     */
    public function to_array();
}
