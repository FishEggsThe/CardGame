if held {
	var heldX = oX + (mouse_x - oMouseX)
	var heldY = oY + (mouse_y - oMouseY)
	PlaceCard(heldX, heldY, id, false)
	
	if mouse_check_button_released(mb_left) {
		held = false
		
		var cardUnder = FindNearestTopCard(id)
		if (cardUnder != noone && cardUnder.cardAbove == noone) {
			var canStack = true
			if Obj_Control.stackHasOrder {
				if !Obj_Control.stackOrder(cardInfo, cardUnder.cardInfo) {canStack = false}
			}
			
			if canStack {
				// Card below placed card
				cardUnder.cardAbove = id
			
				// Card on top
				//cardAbove = noone
				cardBelow = cardUnder
			
				// Positioning placed card over cardUnder nicely
				PlaceCard(cardUnder.x, cardUnder.y, id, true)
			}
		} else if !Obj_Control.freePlace {
			PlaceCard(oX, oY, id, false)
		}
	}
}