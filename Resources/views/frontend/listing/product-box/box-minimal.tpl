{extends file="parent:frontend/listing/product-box/box-minimal.tpl"}

{block name='frontend_listing_box_article_price_discount'}
	{if $sArticle.nnwebpriceonrequest != '1' || $nnwebPriceOnRequest_showPrice == '1'}
		{$smarty.block.parent}
	{/if}
{/block}

{block name='frontend_listing_box_article_price_default'}
	{if $sArticle.nnwebpriceonrequest != '1' || $nnwebPriceOnRequest_showPrice == '1'}
		{$smarty.block.parent}
	{/if}
{/block}