var currDeckSize = array_length(deck)
var trueY = y - cardHeight/2; //var trueX = x + cardHeight*2.25/3.5; 
if currDeckSize > 0 {
	for(var i = currDeckSize-1; i >= 0; i--) {
		var cardInDeckNum = i + (currDeckSize%2 == 1)
		var outlineColor = (cardInDeckNum%2 == 0 || i == 0 ? c_black : c_maroon)
		deck[i].DrawCard(x, trueY-currDeckSize+i+1, outlineColor)
	}
} else {
	DrawNoCard(x, trueY)
}

if Obj_Control.debug {
	draw_set_color(c_white)
	draw_set_halign(fa_left)
	draw_text(5, 25, deck)
	var scale = array_length(deck) - 1
	var scaleText = string(cardHeight) + " + " + string(heightPixelPercent) + " * " + string(scale) + " = " + string(image_yscale)
	draw_text(5, 45, scaleText)
	draw_self()
}
