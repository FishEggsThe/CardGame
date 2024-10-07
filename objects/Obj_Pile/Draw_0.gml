var trueY = y - sprite_get_height(Msk_Deck)/2;
if array_length(pile) <= 0 {DrawNoCard(x, trueY)}
else {pile[0].DrawCard(x, trueY, true)}