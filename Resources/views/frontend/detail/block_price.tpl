{extends file="parent:frontend/detail/block_price.tpl"}

{block name='frontend_detail_data_block_prices'}
    {if $sArticle.nnwebpriceonrequest != '1'}
        {$smarty.block.parent}
    {/if}
{/block}

{block name='frontend_detail_data_block_prices_start'}
    {if $sArticle.nnwebpriceonrequest != '1'}
        {$smarty.block.parent}
    {/if}
{/block}