if mouse_check_button_pressed(mb_left) {
	var cardPicked = false
	for(var i = 0; i < array_length(cardQueue); i++) {
		if position_meeting(mouse_x, mouse_y, cardQueue[i]) {
			cardPicked = true
			// Hold selected card
			with cardQueue[i] {
				if cardBelow != noone {
					cardBelow.cardAbove = noone
					cardBelow = noone
				}
				oX = x; oY = y; held = true
				oMouseX = mouse_x; oMouseY = mouse_y
			}
			
			// Shift priority list
			if i > 0 {
				PrioritizeCard(i)
			}
			break
		}
	}
	if !cardPicked {
		with Obj_Deck {
			if position_meeting(mouse_x, mouse_y, id) {
				if array_length(deck) > 0 {
					if mouse_check_button_pressed(mb_left) {
						CreateCard(deck[0].symbol, deck[0].number, x+150)
						array_delete(deck, 0, 1)
						with Obj_CardPriorityCheck {SetCardDepths()}
					}
				}
			}
		}
	}
}