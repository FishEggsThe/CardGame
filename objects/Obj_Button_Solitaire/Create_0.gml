event_inherited()
label = "Solitaire"
onClick = function() {
	var win = function() {
		with Obj_Pile {
			if array_length(pile) < 13 {
				return false
			}
		}
	}
	
	var start = function() {
		with instance_create_layer(0, 0, "Instances", Obj_Deck) {
			x += sprite_get_width(Msk_Deck) + 5
			y += cardHeight + 5
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