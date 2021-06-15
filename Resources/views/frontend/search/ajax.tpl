{extends file="parent:frontend/search/ajax.tpl"}

{block name="search_ajax_list_entry_price"}
	{if $search_result.nnwebpriceonrequest == '1' && $nnwebPriceOnRequest_showPrice != '1'}
		<span class="entry--price block">
			{s name="PreisAufAnfrage"}Preis auf Anfrage{/s}
        </span>
	{else}
		{$smarty.block.parent}
	{/if}
{/block}