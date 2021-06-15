{extends file="parent:frontend/listing/index.tpl"}

{block name='frontend_listing_box_similar_price'}
	{if $sArticle.nnwebpriceonrequest == '1' && $nnwebPriceOnRequest_showPrice != '1'}
		<p>
			<span class="price">{s name="PreisAufAnfrage"}Preis auf Anfrage{/s}</span>
		</p>
	{else}
		{$smarty.block.parent}
	{/if}
{/block}


