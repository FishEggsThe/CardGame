function Card(_symbol, _number) constructor {
	symbol = _symbol
	number = _number
	
	static DrawCard = function() {
		var width = 50; var height = 50
		draw_set_color(c_white)
		draw_rectangle(x-width, y-height, x+width, y+width, false)
	}
}

function CreateDeck() {
	var deck = array_create(52)
	var symbols = ["hearts", "spades", "diamonds", "clubs"]
	var index = 0; var card = noone
	
	for(var i = 0; i < 4; i++) {
		for(var j = 1; j <= 13; j++) {
			deck[index] = new Card(symbols[i], j);
			//show_debug_message(deck[index])
			index++
		}
	}
	
	return deck
}

function ShuffleDeck(_deck) {
	var deckSize = array_length(_deck)
	var shuffledDeck = array_create(deckSize)
	
	for(var i = deckSize; i > 0; i--) {
		var randomIndex = irandom(i-1)
		shuffledDeck[deckSize-i] = _deck[randomIndex]
		array_delete(_deck, randomIndex, 1)
	}
	
	_deck = shuffledDeck
	//DebugPrintDeck(_deck)
}

function DebugPrintDeck(_deck) {
	array_foreach(_deck, function(_element, _index){
		show_debug_message(string(_index) + ": " + string(_element))
	})
	show_debug_message("")
}