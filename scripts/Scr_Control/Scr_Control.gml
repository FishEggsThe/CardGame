function GameRules(_stack, _freePlace, _placeInDeck, _hasOrder, _win, _order = function(cardA, cardB) {return true}) constructor {
	// Game rules
	stackable = _stack
	stackHasOrder = _order
	stackOrder = _order
	freePlace = _freePlace
	placeInDeck = _placeInDeck
	winCondition = _win
}

function ApplyGameRules(_gamerules) {
	with Obj_Control {
		stackable = _gamerules.stackable
		stackHasOrder = _gamerules.stackHasOrder
		stackOrder = _gamerules.stackOrder
		freePlace = _gamerules.freePlace
		placeInDeck = _gamerules.placeInDeck
		}
		winCondition = _gamerules.winCondition
}