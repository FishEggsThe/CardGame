var currDeckSize = array_length(deck)
if currDeckSize > 0 {
	for(var i = currDeckSize-1; i >= 0; i--) {
		var cardInDeckNum = i + (currDeckSize%2 == 1)
		var outlineColor = (cardInDeckNum%2 == 0 || i == 0 ? c_black : c_maroon)
		deck[i].DrawCard(x, y-currDeckSize+i+1, outlineColor)
	}
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