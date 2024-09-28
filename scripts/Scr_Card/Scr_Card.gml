global.symbols = ["hearts", "spades", "diamonds", "clubs"]

function Card(_symbol, _number) constructor {
	symbol = _symbol
	symbolNum = 0
	for(var i = 0; i < 4; i++) {
		if global.symbols[i] == symbol {
			symbolNum = i
			break
		}
	}
	number = _number
	front = 1
	side = -1
	
	static DrawCard = function(_x, _y) {
		var height = 200; var width = height*2.25/3.5
		var halfHeight = height/2; var halfWidth = width/2
		var cardColor = (side >= 0 ? c_white : c_red)
		
		//side = sin(current_time/2000)
		if keyboard_check_pressed(vk_space) {front*=-1}
		side = lerp(side, front, 0.3)
		
		draw_set_color(cardColor)
		draw_roundrect(_x-halfWidth*side, _y-halfHeight, _x+halfWidth*side, _y+halfHeight, false)
		if side >= 0 {
			for(var i = -1; i <= 1; i+=2) {
				draw_sprite_ext(chives, symbolNum, _x+(-i)*side*halfWidth, _y+i*halfHeight,
								side, 1, 180*(i==1), c_white, 1)
			}
		}
	}
}

function CreateDeck(_shuffle = true) {
	var deck = array_create(52)
	var index = 0; var card = noone
	
	for(var i = 0; i < 4; i++) {
		for(var j = 1; j <= 13; j++) {
			deck[index] = new Card(global.symbols[i], j);
			//show_debug_message(deck[index])
			index++
		}
	}
	
	if _shuffle {deck = ShuffleDeck(deck)}
	
	return deck
}

function ShuffleDeck(_deck) {
	var deckSize = array_length(_deck)
	var shuffledDeck = []
	
	for(var i = deckSize; i > 0; i--) {
		var randomIndex = irandom(i-1)
		shuffledDeck[deckSize-i] = _deck[randomIndex]
		array_delete(_deck, randomIndex, 1)
		//show_debug_message(string(array_length(_deck)) + " / " + string(array_length(shuffledDeck)) + "\n")
	}
	
	//show_debug_message("Final: " + string(array_length(_deck)) + " / " + string(array_length(shuffledDeck)) + "\n")
	return shuffledDeck
	//DebugPrintDeck(_deck)
}

function DebugPrintDeck(_deck) {
	array_foreach(_deck, function(_element, _index){
		show_debug_message(string(_index) + ": " + string(_element))
	})
	show_debug_message("")
}