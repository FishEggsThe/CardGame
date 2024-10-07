if instance_number(Obj_Control) > 1 {
	instance_destroy()
	exit
}

debug = false

// Game rules
stackable = true
stackHasOrder = true
stackOrder = function(cardA, cardB) {
	return true
}
freePlace = true
placeInDeck = true
winCondition = function() {
	return false
}
startBoard = function() {show_debug_message("Clearing the dillywop")}
won = false
