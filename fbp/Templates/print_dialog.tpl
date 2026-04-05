{if $is_smartphone}
<p style="margin-top:20px;" class="pdf_download_message">{t key="pdf.download_ready"}</p>
<a href="{$url}" target="_blank" class="pdf_downloadbutton">{t key="common.download"}</a>
{else}
<iframe src="{$root_url}apppdf.php?time={$time}" style="width:100%;height:500px;border:0px;"></iframe>
{/if}
