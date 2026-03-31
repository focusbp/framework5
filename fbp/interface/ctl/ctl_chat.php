<?php

interface ctl_chat {
	
	/**
	 * Displays a text message in the chat.
	 *
	 * @param string $message The message to display.
	 * @param string $align The alignment of the message (either 'left' or 'right').
	 * @return void
	 */
	function chat_show_text($message, $align = "left", $overwrite = false);
	
	/**
	 * Displays HTML in the chat using a Smarty template.
	 *
	 * @param string $template_name The name of the Smarty template.
	 * @param string $align The alignment of the content (either 'left' or 'right').
	 * @param bool $overwrite Whether to overwrite the existing content.
	 * @return void
	 */
	function chat_show_html($template_name, $align = "left", $overwrite = false);
	
	/**
	 * Clears the chat display.
	 *
	 * @param string|null $chatid The ID of the chat to clear.
	 * @return void
	 */
	function chat_clear($chatid);
	
	function chat_clear_after();
	
	/**
	 * Sets the login status for a user.
	 *
	 * @param string $table_name The name of the table.
	 * @param int $id The ID of the member to log in.
	 * @return void
	 */
	function chat_set_login($table_name, $id);
	
	/**
	 * Logs out the current user.
	 *
	 * @return void
	 */
	function chat_set_logout();
	
	/**
	 * Checks if the user is currently logged in.
	 *
	 * @return bool Returns true if the user is logged in, otherwise false.
	 */
	function chat_is_logined();
	
	/**
	 * Retrieves the information of the currently logged-in member.
	 *
	 * @return array An array containing the logged-in member's information.
	 */
	function chat_get_login_member();
	
	/**
	 * Retrieves the table name used by the logged-in member.
	 *
	 * @return string The name of the table for the logged-in member.
	 */
	function chat_get_login_table();
	
	/**
	 * Updates the information of the logged-in member.
	 *
	 * @param array $data The member data to update.
	 * @return void
	 */
	function chat_update_login_member($data);
}
