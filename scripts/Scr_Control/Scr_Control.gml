function GameRules(_stack, _freePlace, _placeInDeck, _hasOrder, _order = function() {show_debug_message("If you see this message, that means that this message has breached containment")}) constructor {
	// Game rules
	stackable = true
	stackHasOrder = true
	stackOrder = function(cardA, cardB) {
		var numCheck = cardA.number+1 == cardB.number
		var symbolCheck = cardA.symbolNum%2 != cardB.symbolNum%2
		return (numCheck && symbolCheck)
	}
	freePlace = true
	placeInDeck = true
}

function ApplyGameRules(_gamerules) {
	with Obj_Control {
		stackable = _gamerules.stackable
		stackHasOrder = _gamerules.stackHasOrder
		stackOrder = _gamerules.stackOrder
		freePlace = _gamerules.freePlace
		placeInDeck = _gamerules.placeInDeck
		}
}