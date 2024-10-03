deck = CreateDeck()
deckSize = array_length(deck)
DebugPrintDeck(deck)

mask_index = Msk_Deck
cardHeight = sprite_get_height(Msk_Deck)
heightPixelPercent = 1 / cardHeight
depth = 1

image_alpha = 0.5