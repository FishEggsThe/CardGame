//if position_meeting(mouse_x, mouse_y, id) {
//	if mouse_check_button_pressed(mb_left) {
//		oX = x; oY = y; held = true
//		oMouseX = mouse_x; oMouseY = mouse_y
//	}
//}

if held {
	x = oX + (mouse_x - oMouseX)
	y = oY + (mouse_y - oMouseY)
	if mouse_check_button_released(mb_left) {
		held = false
		
		var cardUnder = FindNearestTopCard(id)
		if (cardUnder != noone && cardUnder.cardAbove == noone) {
			// Card below placed card
			cardUnder.cardAbove = id
			
			// Card on top
			cardAbove = noone
			cardBelow = cardUnder
			
		}
	}
}