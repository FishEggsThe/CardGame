if held {
	var heldX = oX + (mouse_x - oMouseX)
	var heldY = oY + (mouse_y - oMouseY)
	PlaceCard(heldX, heldY, id, false)
	x = gotoX
	y = gotoY
} else {
	var lerpVal = 0.5
	x = lerp(x, gotoX, lerpVal)
	y = lerp(y, gotoY, lerpVal)
}

if cardAbove == noone {
	cardInfo.front = 1
}
