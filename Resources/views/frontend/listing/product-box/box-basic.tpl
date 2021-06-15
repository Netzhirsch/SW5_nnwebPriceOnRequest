{extends file="parent:frontend/listing/product-box/box-basic.tpl"}

{block name="frontend_listing_box_article_buy"}
	{if $sArticle.nnwebpriceonrequest == '1'}
		{$sArticle.allowBuyInListing = false}
	{/if}
	
	{$smarty.block.parent}
{/block}