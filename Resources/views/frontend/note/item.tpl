{extends file="parent:frontend/note/item.tpl"}

{block name="frontend_note_item_price"}
	{if $sBasketItem.nnwebpriceonrequest == '1' && $nnwebPriceOnRequest_showPrice != '1'}
		<div class="note--price">{s name="PreisAufAnfrage"}Preis auf Anfrage{/s}</div>
	{else}
		{$smarty.block.parent}
	{/if}
{/block}

{block name="frontend_note_item_unitprice"}{/block}