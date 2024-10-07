if position_meeting(mouse_x, mouse_y, id)
	if mouse_check_button(mb_left) {
		drawY = y+5
	} else {
		drawY = y
	}

	if mouse_check_button_released(mb_left) {
		onClick()
	}
}