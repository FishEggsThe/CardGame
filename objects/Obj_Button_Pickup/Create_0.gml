event_inherited()
label = "52 Pickup"
onClick = function() {
	var win = function() {
		if array_length(Obj_Deck.deck) >= 52 {
			return true
		}
		return false
	}
	
	var start = function() {
		with instance_create_layer(room_width/2, room_height/2, "Instances", Obj_Deck) {
			deck = []
			y+=cardHeight/2
		}
		var hand = CreateDeck()
		for(var i = 0; i < array_length(hand); i++) {
			with CreateCard(hand[i].symbol, hand[i].number, room_width/2, -200) {
				gotoX = random_range(100, room_width-100)
				gotoY = random_range(200, room_height-100)
				if place_meeting(gotoX, gotoY, Obj_Deck) {
					var pushTo = point_direction(Obj_Deck.x, Obj_Deck.y, gotoX, gotoY)
					gotoX += 200*cos(degtorad(pushTo))
					gotoY += 300*sin(degtorad(pushTo))
				}
			}
		}
	}
	
	ApplyGameRules(new GameRules(false, true, true, false, start, win))
	room_goto(Rm_Pickup)
}