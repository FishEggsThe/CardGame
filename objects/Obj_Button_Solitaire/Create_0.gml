event_inherited()
label = "Solitaire"
onClick = function() {
	var win = function() {
		with Obj_Pile {
			if array_length(pile) < 13 {
				return false
			}
		}
		return true
	}
	
	var start = function() {
		var width = sprite_get_width(Msk_Deck)
		var deck = instance_create_layer(0, 0, "Instances", Obj_Deck)
		with deck {
			x += width + 50
			y += cardHeight + 70
		}
		
		var numOfExtraCards = 0
		for(var i = 0; i < 7; i++) {
			with instance_create_layer(0, 0, "Instances", Obj_CardHolder) {
				x += width + i*width*1.1 + 50
				y += Obj_Deck.cardHeight*3/2 + 80
				stackRule = function(_card) {
					if _card.number == 13 {return true}
					return false
				}
				
				var card = DrawFromDeck(deck, x, y, -1)
				heldCard = card
				for(var j = 0; j < numOfExtraCards; j++) {
					var extraCard = DrawFromDeck(deck, 0, 0, -1)
					card.cardAbove = extraCard
					extraCard.cardBelow = card
					card = extraCard
				}
				PlaceCard(x, y, heldCard, false)
			}
			numOfExtraCards++
		}
	}
	
	var order = function(cardA, cardB) {
		var numCheck = cardA.number+1 == cardB.number
		var symbolCheck = cardA.symbolNum%2 != cardB.symbolNum%2
		return (numCheck && symbolCheck)
	}
	
	ApplyGameRules(new GameRules(true, false, false, true, start, win, order))
	room_goto(Rm_Solitaire)
}