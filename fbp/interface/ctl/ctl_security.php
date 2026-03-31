<?php

interface ctl_security {

	/**
	 * Enables or disables login check for the administrative side.
	 *
	 * @param bool $flg Set to true to enable login check, false to disable it.
	 * @return void
	 */
	function set_check_login($flg);

	/**
	 * Retrieves the current state of login check for the administrative side.
	 *
	 * @return bool True if login check is enabled, false otherwise.
	 */
	function get_check_login();

	/**
	 * Retrieves the login name of the currently logged-in administrative user.
	 *
	 * @return string|null The login name of the administrative user, or null if not logged in.
	 */
	function get_login_name();

	/**
	 * Retrieves the login ID of the currently logged-in administrative user.
	 *
	 * @return string|null The login ID of the administrative user, or null if not logged in.
	 */
	function get_login_id();

	/**
	 * Retrieves the user ID of the currently logged-in administrative user.
	 *
	 * @return int|null The user ID of the administrative user, or null if not logged in.
	 */
	function get_login_user_id();

	/**
	 * Retrieves the login type of the currently logged-in administrative user.
	 *
	 * @return string|null The login type of the administrative user, or null if not logged in.
	 */
	function get_login_type();

	/**
	 * Encrypts the given string for secure storage or transmission.
	 *
	 * @param string $str The string to encrypt.
	 * @return string The encrypted string.
	 */
	function encrypt($str);

	/**
	 * Decrypts the given encrypted value, typically used for administrative purposes.
	 *
	 * @param string $encrypt The encrypted string to decrypt.
	 * @return string The decrypted string.
	 */
	function decrypt($encrypt);
}
