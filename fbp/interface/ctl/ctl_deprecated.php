<?php


interface ctl_deprecated {
	
	/**
	 * Squareアプリケーションとの連携を設定します。
	 *
	 * @param string|null $square_application_id SquareアプリケーションID。
	 * @param string|null $square_access_token Squareアクセス トークン。
	 * @param string|null $square_location_id SquareロケーションID。
	 * @return void
	 */
	function set_square($square_application_id=null,$square_access_token=null,$square_location_id=null);
	
	/**
	 * @deprecated 代わりに show_pdfを使用して下さい。
	 */
	function res_pdf($imgdir,$pdf_template,$download_filename,$title="印刷",$width=600);

	/**
	 * @deprecated 代わりにshow_multi_dialogを使用して下さい
	 */
	function res_dialog($title,$template,$options=array());
	
	
	/**
	 * @deprecated このメソッドは廃止になりました。
	 */
	function list_reset();
	
        function show_popup($template,$width=300,$height=200);
	
	/**
	 * 指定されたメッセージをログに出力します。
	 *
	 * @param string $log 出力するログメッセージ。
	 * @return void
	 */
	function cron_log($log);
	
	function set_css_other_class($class_name);
	
	function json_decode_from_chatGPT($text);

	
	/**
	 * Smartyオブジェクトを返しますが、通常は使用しません。
	 * 
	 * @return Smarty Smartyオブジェクトを返します。
	 */
	function smarty();
	


	
}
