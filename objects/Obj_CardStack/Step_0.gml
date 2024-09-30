if position_meeting(mouse_x, mouse_y, id) {
	if array_length(deck) > 0 {
		if mouse_check_button_pressed(mb_left) {
			CreateCard(deck[0].symbol, deck[0].number, x+230)
			array_delete(deck, 0, 1)
		}
	}
}