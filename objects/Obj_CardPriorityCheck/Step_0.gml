if mouse_check_button_pressed(mb_left) {
	for(var i = 0; i < array_length(cardQueue); i++) {
		if position_meeting(mouse_x, mouse_y, cardQueue[i]) {
			
			with cardQueue[i] {
				oX = x; oY = y; held = true
				oMouseX = mouse_x; oMouseY = mouse_y
			}
			if i > 0 {
				array_insert(cardQueue, 0, cardQueue[i])
				array_delete(cardQueue, i+1, 1)
				
				array_foreach(cardQueue, function(_element, _index){
					_element.depth = -instance_number(Obj_Card) + _index
				})
			}
			break
		}
	}
}