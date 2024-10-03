if array_length(deck) > 0 {
	array_foreach(deck, function(_element, _index) {
		var outlineColor = (_index%2 == 0 ? c_black : c_maroon)
		_element.DrawCard(x, y-_index, outlineColor)
	});
	//deck[0].DrawCard(x, y)
} else {
	var height = 200; var width = height*2.25/3.5; var border = 5
	var halfHeight = height/2; var halfWidth = width/2
	draw_set_color(c_black)
	draw_roundrect(x-halfWidth+border, y-halfHeight+border, 
				   x+halfWidth-border, y+halfHeight-border, true)
}