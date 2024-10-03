if instance_number(Obj_Control) > 1 {
	instance_destroy()
	exit
}

debug = false

// Game rules
stackable = true
stackHasOrder = true
stackOrder = function(cardA, cardB) {
	return cardA.number > cardB.number
}
freePlace = true
