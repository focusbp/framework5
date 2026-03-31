<?php

namespace chartjs;

/**
 * Interface Chart
 *
 * This interface defines the methods required for creating and configuring a Chart.js chart in PHP.
 */
interface Chart {

    /**
     * Set the type of the chart (e.g., 'line', 'bar', 'pie').
     *
     * @param string $type The type of the chart. Default is 'line'.
     * @return void
     */
    public function set_type($type = "line");

    /**
     * Set the labels for the chart's data.
     *
     * @param array $labels An array of labels for the chart's x-axis.
     * @return void
     */
    public function set_labels(array $labels);

    /**
     * Add a dataset to the chart.
     *
     * @param Dataset $dataset An instance of a dataset class to add to the chart.
     * @return void
     */
    public function add_dataset(Dataset $dataset);

    /**
     * Add an option to the chart's configuration.
     *
     * @param string $key The option key.
     * @param mixed $value The option value.
     * @return void
     */
    public function add_option($key, $value);

    /**
     * Add a scale configuration to the chart.
     *
     * @param string $key The scale key (e.g., 'x', 'y').
     * @param Scale $scale An instance of a Scale class to configure the chart's axis.
     * @return void
     */
    public function add_option_scales($key, Scale $scale);

    /**
     * Convert the chart configuration to an array suitable for Chart.js.
     *
     * @return array An array representing the chart's configuration.
     */
    public function to_array();

    /**
     * Create and return an instance of Dataset_Line class.
     *
     * @return Dataset_Line An instance of the Dataset_Line class.
     */
    public function create_Dataset_Line(): Dataset_Line;

    /**
     * Create and return an instance of Dataset_Bar class.
     *
     * @return Dataset_Bar An instance of the Dataset_Bar class.
     */
    public function create_Dataset_Bar(): Dataset_Bar;

    /**
     * Create and return an instance of Dataset_Bubble class.
     *
     * @return Dataset_Bubble An instance of the Dataset_Bubble class.
     */
    public function create_Dataset_Bubble(): Dataset_Bubble;

    /**
     * Create and return an instance of Dataset_Pie class.
     *
     * @return Dataset_Pie An instance of the Dataset_Pie class.
     */
    public function create_Dataset_Pie(): Dataset_Pie;

    /**
     * Create and return an instance of Dataset_PolarArea class.
     *
     * @return Dataset_PolarArea An instance of the Dataset_PolarArea class.
     */
    public function create_Dataset_PolarArea(): Dataset_PolarArea;

    /**
     * Create and return an instance of Dataset_Radar class.
     *
     * @return Dataset_Radar An instance of the Dataset_Radar class.
     */
    public function create_Dataset_Radar(): Dataset_Radar;

    /**
     * Create and return an instance of Dataset_Scatter class.
     *
     * @return Dataset_Scatter An instance of the Dataset_Scatter class.
     */
    public function create_Dataset_Scatter(): Dataset_Scatter;

    public function create_Dataset_Doughnut(): Dataset_Doughnut;
    
    /**
     * Create and return an instance of Scale class.
     *
     * @param string $id The scale ID (e.g., 'y-axis-1').
     * @param string $type The type of the scale (e.g., 'linear', 'time').
     * @param string $position The position of the scale (e.g., 'left', 'bottom').
     * @return Scale An instance of the Scale class.
     */
    public function create_Scale(string $id, string $type, string $position): Scale;
    
}
