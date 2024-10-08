if Obj_Control.debug {
	draw_set_color(c_black)
	with instance_nearest(mouse_x, mouse_y, Obj_Card) {
		draw_text(x+100, y-15, "ID: " + string(id))
		draw_text(x+100, y, "Below: " + string(cardBelow))
		draw_text(x+100, y+15, "Above: " + string(cardAbove))
	}
}