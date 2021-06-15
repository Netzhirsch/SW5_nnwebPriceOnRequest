{extends file="parent:frontend/detail/index.tpl"}

{# frontend/swag_bundle/bundle.tpl #}
{block name='frontend_listing_box_article_price_default'}
	{if $sArticle.nnwebpriceonrequest == '1' && $nnwebPriceOnRequest_showPrice != '1'}
		<span class="price--default is--nowrap">
			{s name="PreisAufAnfrage"}Preis auf Anfrage{/s}
		</span>
	{else}
		{$smarty.block.parent}
	{/if}
{/block}

{block name="bundle_content_cart_button"}
    {if $sArticle.nnwebpriceonrequest != '1'}
        {$smarty.block.parent}
    {else}
        <div class="content--cart-button">
			{$articleNumbers = ""}
			{foreach $bundle.articles as $product}
				{if $articleNumbers != ""}
					{$articleNumbers = "`$articleNumbers`,"}
				{/if}
				{$articleNumbers = "`$articleNumbers``$product.number`"}
			{/foreach}
            <a class="btn is--primary is--icon-right" href="{url controller='support' action='index' sFid=$nnwebPriceOnRequest_formularID sInquiry='detail' sOrdernumber=$sArticle.ordernumber bundleArticles=$articleNumbers}">
                {s name='PreisAufAnfrage'}Preis auf Anfrage{/s} <i class="icon--arrow-right"></i>
            </a>
        </div>
    {/if}
{/block}


{# frontend/swag_bundle/container/bundle_price.tpl #}
{block name='price_value_bundle_price'}
	{if $sArticle.nnwebpriceonrequest == '1' && $nnwebPriceOnRequest_showPrice != '1'}
		<span class="price--value-bundle-price is--bold" data-bundleId="{$bundle.id}">
			{s name="PreisAufAnfrage"}Preis auf Anfrage{/s}
		</span>
	{else}
		{$smarty.block.parent}
	{/if}
{/block}


{block name='price_value_regular_price'}
	{if $sArticle.nnwebpriceonrequest == '1' && $nnwebPriceOnRequest_showPrice != '1'}
	{else}
		{$smarty.block.parent}
	{/if}
{/block}

{block name='container_price_text'}
    {if $sArticle.nnwebpriceonrequest == '1' && $nnwebPriceOnRequest_showPrice != '1'}
	{else}
		{$smarty.block.parent}
	{/if}
{/block}

{# frontend/swag_bundle/container/bundle_products.tpl #}
{block name='bundle_article_price_supplier'}
    {if $sArticle.nnwebpriceonrequest == '1' && $nnwebPriceOnRequest_showPrice != '1'}
	    <div class="bundle--product-price-supplier">
	        {if $product.supplier}
	            <span class="bundle--product-supplier"> - {$product.supplier}</span>
	        {/if}
	    </div>
	{else}
		{$smarty.block.parent}
	{/if}
{/block}