{extends file="parent:frontend/compare/col.tpl"}

{block name='frontend_compare_price'}
	{if $sArticle.nnwebpriceonrequest == '1' && $nnwebPriceOnRequest_showPrice != '1'}
		{block name='frontend_compare_price_pseudoprice'}{/block}
		{block name='frontend_compare_price_normal'}
			<li class="list--entry entry--price">
				<span class="price--normal">{s name="PreisAufAnfrage"}Preis auf Anfrage{/s}</span>
		{/block}
	{else}
		{$smarty.block.parent}
	{/if}
{/block}


{block name='frontend_compare_unitprice'}
	{if $sArticle.nnwebpriceonrequest == '1' && $nnwebPriceOnRequest_showPrice != '1'}
			</li>
	{else}
		{$smarty.block.parent}
	{/if}
{/block}