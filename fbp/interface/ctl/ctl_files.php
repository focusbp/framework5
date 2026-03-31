<?php

interface ctl_files {

	/* =========================================================
	 *  Filename-based operations
	 *  All functions operate only within the system's "upload folder".
	 * ========================================================= */

	/**
	 * Saves arbitrary data to a file (within the upload folder only).
	 *
	 * @param string $filename The target filename (relative to the upload folder).
	 * @param mixed  $data     The data to be written (string, binary, etc.).
	 * @return void
	 */
	public function save_file($filename, $data);
	
	public function read_file($filename);

	/**
	 * Retrieves the absolute file path of a saved file (within the upload folder only).
	 *
	 * @param string $filename The name of the saved file (relative to the upload folder).
	 * @return string The full file path. Behavior if the file does not exist is implementation-dependent.
	 */
	public function get_saved_file_path($filename);
	
	/**
	 * Checks whether a saved file exists (within the upload folder only).
	 *
	 * @param string $filename The name of the saved file (relative to the upload folder).
	 * @return bool True if the file exists, false otherwise.
	 */
	public function is_saved_file($filename);

	/**
	 * Deletes a saved file (within the upload folder only).
	 *
	 * @param string $filename The filename to delete (relative to the upload folder).
	 * @return void
	 */
	public function delete_saved_file($filename);
	
	/**
	 * Copies a file within the upload folder (both source and destination must be inside).
	 *
	 * @param string $src_filename The source filename (relative to the upload folder).
	 * @param string $to_filename  The destination filename (relative to the upload folder).
	 * @return void
	 */
	public function copy_saved_file($src_filename, $to_filename);

	/**
	 * Retrieves a list of files from a subdirectory (within the upload folder only).
	 *
	 * @param string|null $subdir    The subdirectory to scan (null for the root of the upload folder).
	 * @param bool        $recursive Whether to scan recursively.
	 * @param int         $flags     Flags that modify the search behavior (implementation-dependent).
	 * @return array A list of files/directories (format is implementation-dependent).
	 */
	public function get_file_list($subdir = null, $recursive = false, $flags = 0);

	/**
	 * Deletes the specified subdirectory and its contents (within the upload folder only).
	 *
	 * @param string $subdir The subdirectory to delete (relative to the upload folder).
	 * @return bool True on success, false on failure.
	 */
	public function delete_folder($subdir);


	/**
	 * Extracts a ZIP file into a target subdirectory (all within the upload folder).
	 *
	 * @param string $zip_filename The ZIP file to extract (relative to the upload folder).
	 * @param string $subdir       The target subdirectory for extraction (relative to the upload folder).
	 * @return bool True on success, false on failure.
	 */
	public function unzip($zip_filename, $subdir);


	/* =========================================================
	 *  ID-based operations
	 *  All physical files are stored in and managed under the system's upload folder.
	 * ========================================================= */

	/**
	 * Handles a file uploaded via a form, stores it in the upload folder,
	 * optionally resizes the image (main/thumbnail), and returns a file ID.
	 *
	 * @param string      $parameter_name        The $_FILES key.
	 * @param int|null    $image_width           Maximum width for the main image (px). Null = no resize.
	 * @param int|null    $image_width_thumbnail Maximum width for the thumbnail (px). Null = no thumbnail.
	 * @param string|null $table_identifier      Optional table identifier for linking. Used to save the relationship with a specific table so that related files can be managed together.
	 * @param int|null    $row_id                Optional row ID for linking. Used together with $table_identifier to associate the file with a specific row, allowing all related files to be deleted automatically when the row is removed.
	 * @return int The unique ID of the registered file.
	 */
	public function store_posted_file($parameter_name, $image_width = null, $image_width_thumbnail = null, $table_name = null, $row_id = null,$key = null);

	/**
	 * Deletes a file and its metadata by file ID (physical file is in the upload folder).
	 *
	 * @param int $file_id The file ID to delete.
	 * @return void
	 */
	public function delete_file($file_id);
	
	/**
	 * Retrieves file information array for a given file ID.
	 * Physical files are stored in the upload folder.
	 *
	 * @param int $id The file ID.
	 * @return array|false File data (implementation-defined). False if not found.
	 */
	public function get_file_info($id,$encrypt=true);

	/**
	 * Saves or updates files associated with an existing record ($table_name, $row).
	 * Physical files are stored in the upload folder.
	 * The generated file ID will be stored in $row["parameter_name"].
	 *
	 * @param string $table_name The table name.
	 * @param array  $row        The row data (passed by reference).
	 * @return void
	 */
	public function save_posted_files($table_name, &$row);

	/**
	 * Deletes all files associated with a given record ($table_name, $row_id).
	 * Physical files are deleted from the upload folder.
	 *
	 * @param string $table_name The table name.
	 * @param int    $row_id     The row ID whose files should be deleted.
	 * @return void
	 */
	public function delete_files($table_name, $row_id);
	
	public function get_posted_file_keys($parameter_name);
	
	function is_posted_file($post_name);
	
	function get_posted_filename($post_name,$key=null);


}
