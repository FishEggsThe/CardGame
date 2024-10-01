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
	front = -1
	side = -1
	
	static DrawCard = function(_x, _y) {
		var height = 200; var width = height*2.25/3.5
		var halfHeight = height/2; var halfWidth = width/2
		var cardColor = c_red; var border = 5
		
		if keyboard_check_pressed(vk_space) {FlipCard()} // Put in debug
		side = lerp(side, front, 0.3)
		
		draw_set_color(cardColor)
		draw_roundrect(_x-halfWidth*side, _y-halfHeight, _x+halfWidth*side, _y+halfHeight, false)
		if side >= 0 {
			draw_set_color(c_white)
			draw_roundrect(_x-halfWidth*side+border, _y-halfHeight+border, _x+halfWidth*side-border, _y+halfHeight-border, false)
			for(var i = -1; i <= 1; i+=2) {
				draw_sprite_ext(chives, symbolNum, _x+(-i)*side*halfWidth+border*i, _y+i*halfHeight+border*(-i),
								side, 1, 180*(i==1), c_white, 1)
				
				draw_set_halign(fa_left); draw_set_valign(fa_top); draw_set_color(c_black)
				draw_text_transformed(_x+(-i)*(-side)*halfWidth+border*(-i), _y+i*halfHeight+border*(-i), number, 1, 1, 180*(i==1))
			}
		}
	}
	static FlipCard = function() {
		front *= -1
	}
}

function CreateCard(_symbol, _number, _x = x, _y = y) {
	var card = instance_create_depth(_x, _y, -instance_number(Obj_Card), Obj_Card)
	with card {
		cardInfo = new Card(_symbol, _number)
		cardInfo.FlipCard()
	}
	array_insert(Obj_CardPriorityCheck.cardQueue, 0, card)
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

function PrioritizeCard(_i) {
	array_insert(cardQueue, 0, cardQueue[_i])
	array_delete(cardQueue, _i+1, 1)
				
	array_foreach(cardQueue, function(_element, _index){
		_element.depth = _index - instance_number(Obj_Card)
	});
}

function FindNearestTopCard(_card) {
	// Create list of cards touching _card ordered by distance (Thanks instance_place_list)
	var topCards = ds_list_create()
	var numOfTopCards = instance_place_list(x, y, Obj_Card, topCards, true)
	//if numOfTopCards <= 0 {return noone}
	
	// Find the closest top card
	for(var i = 0; i < numOfTopCards; i++) {
		var nextTopCard = topCards[| i]
		if nextTopCard.cardAbove == noone {
			return nextTopCard
		}
	}
	return noone
}

function DebugPrintDeck(_deck) {
	array_foreach(_deck, function(_element, _index){
		show_debug_message(string(_index) + ": " + string(_element))
	})
	show_debug_message("")
}