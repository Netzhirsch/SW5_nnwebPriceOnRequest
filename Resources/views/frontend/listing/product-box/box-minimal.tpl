{extends file="parent:frontend/listing/product-box/box-minimal.tpl"}

{block name='frontend_listing_box_article_price_discount'}
	{if $sArticle.nnwebpriceonrequest != '1' || $nnwebPriceOnRequest_showPrice == '1'}
		{$smarty.block.parent}
	{/if}
{/block}

{block name='frontend_listing_box_article_price_default'}
	{if $sArticle.nnwebpriceonrequest == '1' && $nnwebPriceOnRequest_showPrice != '1'}
		<span class="price--default is--nowrap">
			{s name="PreisAufAnfrage"}Preis auf Anfrage{/s}
		</span>
	{else}
		{$smarty.block.parent}
	{/if}
{/block}

{block name="frontend_listing_box_article_buy"}
	{if $sArticle.nnwebpriceonrequest == '1'}
		{$sArticle.allowBuyInListing = false}
	{/if}
	
	{$smarty.block.parent}
{/block}