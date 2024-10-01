if held {
	x = oX + (mouse_x - oMouseX)
	y = oY + (mouse_y - oMouseY)
	var xOffset = 5; var yOffset = 50
	var nextCard = cardAbove
	while (nextCard != noone) {
		nextCard.x = nextCard.cardBelow.x + xOffset
		nextCard.y = nextCard.cardBelow.y + yOffset
		nextCard = nextCard.cardAbove
	}
	
	if mouse_check_button_released(mb_left) {
		held = false
		
		var cardUnder = FindNearestTopCard(id)
		if (cardUnder != noone && cardUnder.cardAbove == noone) {
			// Card below placed card
			cardUnder.cardAbove = id
			
			// Card on top
			cardAbove = noone
			cardBelow = cardUnder
			
			// Positioning placed card over cardUnder nicely
			x = cardUnder.x + xOffset
			y = cardUnder.y + yOffset
			nextCard = cardAbove
			//while (nextCard != noone) {
			//	nextCard.x = nextCard.cardBelow.x + xOffset
			//	nextCard.y = nextCard.cardBelow.y + yOffset
			//	nextCard = nextCard.cardAbove
			//}
		}
	}
}