{extends file="parent:frontend/detail/buy.tpl"}

{block name="frontend_detail_buy"}
    {if $sArticle.nnwebpriceonrequest != '1'}
        {$smarty.block.parent}
    {else}

        <input type="hidden" name="sActionIdentifier" value="{$sUniqueRand}"/>
        <input type="hidden" name="sAddAccessories" id="sAddAccessories" value=""/>

        <input type="hidden" name="sAdd" value="{$sArticle.ordernumber}"/>

        <div class="buybox--button-container block-group">
            <a class="buybox--button block btn is--primary is--icon-right is--center is--large" href="{url controller='support' action='index' sFid=$nnwebPriceOnRequest_formularID sInquiry='detail' sOrdernumber=$sArticle.ordernumber}" title="{s name='PreisAufAnfrage'}Preis auf Anfrage{/s}">
                {s name='PreisAufAnfrage'}Preis auf Anfrage{/s} <i class="icon--arrow-right"></i>
            </a>
        </div>
    {/if}
{/block}