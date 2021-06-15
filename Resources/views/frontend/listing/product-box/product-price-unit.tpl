{extends file="parent:frontend/listing/product-box/product-price-unit.tpl"}

{block name='frontend_listing_box_article_unit_label'}
	{if $sArticle.nnwebpriceonrequest != '1' || $nnwebPriceOnRequest_showPrice == '1'}
		{$smarty.block.parent}
	{/if}
{/block}

{block name='frontend_listing_box_article_unit_content'}
	{if $sArticle.nnwebpriceonrequest != '1' || $nnwebPriceOnRequest_showPrice == '1'}
		{$smarty.block.parent}
	{/if}
{/block}

{block name='frontend_listing_box_article_unit_reference_content'}
	{if $sArticle.nnwebpriceonrequest != '1' || $nnwebPriceOnRequest_showPrice == '1'}
		{$smarty.block.parent}
	{/if}
{/block}