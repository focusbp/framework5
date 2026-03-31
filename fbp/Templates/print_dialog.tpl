{if $is_smartphone}
<p style="margin-top:20px;" class="lang pdf_download_message">The PDF is ready. Please click the button below to download it.</p>
<a href="{$url}" target="_blank" class="lang pdf_downloadbutton">Download</a>
{else}
<iframe src="{$root_url}apppdf.php?time={$time}" style="width:100%;height:500px;border:0px;"></iframe>
{/if}
