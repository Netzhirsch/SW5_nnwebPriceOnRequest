{extends file="parent:frontend/detail/data.tpl"}

{block name='frontend_detail_data_price_configurator'}
	{if $sArticle.nnwebpriceonrequest == '1' && $nnwebPriceOnRequest_showPrice != '1'}
		<span class="price--content">{s name="PreisAufAnfrage"}Preis auf Anfrage{/s}</span>
	{else}
		{$smarty.block.parent}
	{/if}
{/block}

{block name="frontend_detail_data_block_price_include"}
	{if $sArticle.nnwebpriceonrequest != '1'}
		{$smarty.block.parent}
	{else}
		<div class="block-prices--container">
			<b>{s name="PreisAufAnfrage"}Preis auf Anfrage{/s}</b>
		</div>
	{/if}
{/block}

{block name='frontend_detail_data_pseudo_price'}
	{if $sArticle.nnwebpriceonrequest != '1'}
		{$smarty.block.parent}
	{/if}
{/block}

{block name='frontend_detail_data_price'}
	{if $sArticle.nnwebpriceonrequest != '1'}
		{$smarty.block.parent}
	{/if}
{/block}

{block name="frontend_detail_data_delivery"}
	{if $sArticle.nnwebpriceonrequest != '1'}
		{$smarty.block.parent}
	{/if}
{/block}