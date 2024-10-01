if mouse_check_button_pressed(mb_left) {
	for(var i = 0; i < array_length(cardQueue); i++) {
		if position_meeting(mouse_x, mouse_y, cardQueue[i]) {
			// Hold selected card
			with cardQueue[i] {
				if stackedOn != noone {
					stackedOn.top = true
					stackedOn = noone
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
}