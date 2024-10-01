if held {
	x = oX + (mouse_x - oMouseX)
	y = oY + (mouse_y - oMouseY)
	var nextCard = cardAbove; var yOffset = 50
	while (nextCard != noone) {
		nextCard.x = nextCard.cardBelow.x
		nextCard.y = nextCard.cardBelow.y + yOffset
		nextCard = nextCard.cardAbove
	}
	
	if mouse_check_button_released(mb_left) {
		held = false
		
		var cardUnder = FindNearestTopCard(id)
		if (cardUnder != noone && cardUnder.cardAbove == noone) {
			if cardUnder.cardBelow != id {
				// Card below placed card
				cardUnder.cardAbove = id
			
				// Card on top
				cardAbove = noone
				cardBelow = cardUnder
			}
			
			// Positioning placed card over cardUnder nicely
			x = cardUnder.x
			y = cardUnder.y + 50
		}
	}
}