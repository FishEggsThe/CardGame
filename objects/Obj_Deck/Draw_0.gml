var deckSize = array_length(deck)
if deckSize > 0 {
	for(var i = deckSize-1; i >= 0; i--) {
		var outlineColor = (i%2 == 0 ? c_black : c_maroon)
		deck[i].DrawCard(x, y-deckSize+i+1, outlineColor)
	}
	//array_foreach(deck, function(_element, _index) {
	//	var outlineColor = (_index%2 == 0 ? c_black : c_maroon)
	//	_element.DrawCard(x, y-_index, outlineColor)
	//});
	//deck[0].DrawCard(x, y)
} else {
	var height = 200; var width = height*2.25/3.5; var border = 5
	var halfHeight = height/2; var halfWidth = width/2
	draw_set_color(c_black)
	draw_roundrect(x-halfWidth+border, y-halfHeight+border, 
				   x+halfWidth-border, y+halfHeight-border, true)
}

if Obj_Control.debug {
	draw_set_color(c_white)
	draw_set_halign(fa_left)
	draw_text(5, 15, deck)
}