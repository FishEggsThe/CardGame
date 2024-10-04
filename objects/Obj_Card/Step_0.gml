if held {
	var heldX = oX + (mouse_x - oMouseX)
	var heldY = oY + (mouse_y - oMouseY)
	PlaceCard(heldX, heldY, id, false)
} //else {
var lerpVal = 0.5
x = lerp(x, gotoX, lerpVal)
y = lerp(y, gotoY, lerpVal)
//}