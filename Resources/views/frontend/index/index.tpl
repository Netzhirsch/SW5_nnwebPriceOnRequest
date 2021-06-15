{extends file="parent:frontend/index/index.tpl"}

{block name='frontend_index_header_meta_tags_opengraph' prepend}
    {if $sArticle.nnwebpriceonrequest == '1' && $nnwebPriceOnRequest_showPrice != '1'}
        {$sArticle.price=0}
    {/if}
{/block}