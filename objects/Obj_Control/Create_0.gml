if instance_number(Obj_Control) > 1 {
	instance_destroy()
	exit
}

debug = false

// Game rules
stackable = true
stackHasOrder = true
stackOrder = function(cardA, cardB) {
	var numCheck = cardA.number+1 == cardB.number
	var symbolCheck = cardA.symbolNum%2 != cardB.symbolNum%2
	return (numCheck && symbolCheck)
	//return true
}
freePlace = true
placeInDeck = true
