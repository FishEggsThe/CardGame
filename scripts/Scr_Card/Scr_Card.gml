function CardInfo(_symbol, _number) constructor {
	symbol = _symbol
	number = _number
	
	width = 50; height = 50
	static DrawCard = function() {
		draw_set_color(c_white)
		draw_rectangle(x-width, y-height, x+width, y+width, false)
	}
}