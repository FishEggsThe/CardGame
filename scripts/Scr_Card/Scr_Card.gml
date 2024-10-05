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
	
	static DrawCard = function(_x, _y, outlineColor = c_black) {
		var height = 200; var width = height*2.25/3.5
		var halfHeight = height/2; var halfWidth = width/2
		var cardColor = [c_red, c_black]; var border = 5
		var backColor = c_maroon
		
		if keyboard_check_pressed(vk_space) {FlipCard()}
		side = lerp(side, front, 0.3)
		
		if side >= 0 {
			draw_set_color(cardColor[symbolNum%2])
			draw_roundrect(_x-halfWidth*side, _y-halfHeight, _x+halfWidth*side, _y+halfHeight, false)
			draw_set_color(c_white)
			draw_roundrect(_x-halfWidth*side+border, _y-halfHeight+border, _x+halfWidth*side-border, _y+halfHeight-border, false)
			for(var i = -1; i <= 1; i+=2) {
				draw_sprite_ext(chives, symbolNum, _x+(-i)*side*halfWidth+border*i, _y+i*halfHeight+border*(-i),
								side, 1, 180*(i==1), c_white, 1)
				
				draw_set_halign(fa_left); draw_set_valign(fa_top); draw_set_color(c_black)
				draw_text_transformed(_x+(-i)*(-side)*halfWidth+border*(-i), _y+i*halfHeight+border*(-i), number, 1, 1, 180*(i==1))
			}
		} else {
			draw_set_color(backColor)
			draw_roundrect(_x-halfWidth*side, _y-halfHeight, _x+halfWidth*side, _y+halfHeight, false)
		}
		draw_set_color(outlineColor)
		draw_roundrect(_x-halfWidth*side, _y-halfHeight, _x+halfWidth*side, _y+halfHeight, true)
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
	return card
}

function PlaceCard(_x, _y, _card, _onCard) {
	var xOffset = 5; var yOffset = 50
	_card.gotoX = _x + (xOffset*_onCard)
	_card.gotoY = _y + (yOffset*_onCard)
	var nextCard = _card.cardAbove
	while (nextCard != noone) {
		nextCard.gotoX = nextCard.cardBelow.gotoX + xOffset
		nextCard.gotoY = nextCard.cardBelow.gotoY + yOffset
		nextCard = nextCard.cardAbove
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

function AddToDeck(_card, _deck) {
	if _card.cardAbove != noone {return _deck}
	
	_card.cardInfo.front = -1
	array_insert(_deck, 0, _card.cardInfo)
	array_delete(Obj_CardPriorityCheck.cardQueue, 0, 1)
	instance_destroy(_card)
	return _deck
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

function ParseThroughStackAbove(_card, _function) {
	var nextCard = _card.cardAbove
	while (nextCard != noone) {
		_function(nextCard)
		nextCard = nextCard.cardAbove
	}
}

function SetCardDepths() {
	array_foreach(cardQueue, function(_element, _index){
		_element.depth = _index - instance_number(Obj_Card)
	});
}

function PrioritizeCard(_i) {
	array_insert(cardQueue, 0, cardQueue[_i])
	array_delete(cardQueue, _i+1, 1)
	
	ParseThroughStackAbove(cardQueue[0], function(_nextCard) {
		var nextI = array_get_index(cardQueue, _nextCard)
		array_insert(cardQueue, 0, cardQueue[nextI])
		array_delete(cardQueue, nextI+1, 1)
	});
				
	SetCardDepths()
}

function FindNearestTopCard(_card) {
	// Returns noone if stacking is not allowed
	if !Obj_Control.stackable {return noone}
	
	// Create list of cards touching _card ordered by distance (Thanks instance_place_list)
	var topCards = ds_list_create()
	var numOfTopCards = instance_place_list(x, y, Obj_Card, topCards, true)
	
	// Take out cards that are stacked above it
	var nextCard = _card.cardAbove
	while (nextCard != noone) {
		var index = ds_list_find_index(topCards, nextCard)
		ds_list_delete(topCards, index)
		nextCard = nextCard.cardAbove
	}
	numOfTopCards = ds_list_size(topCards)
	
	// Find the closest top card
	var chosenTopCard = noone
	for(var i = 0; i < numOfTopCards; i++) {
		var nextTopCard = topCards[| i]
		if nextTopCard.cardAbove == noone {
			chosenTopCard = nextTopCard
			break
		}
	}
	ds_list_destroy(topCards)
	return chosenTopCard
}

function DrawNoCard(_x, _y) {
	var height = 200; var width = height*2.25/3.5; var border = 5
	var halfHeight = height/2; var halfWidth = width/2
	draw_set_color(c_black)
	draw_roundrect(_x-halfWidth+border, _y-halfHeight+border, 
				   _x+halfWidth-border, _y+halfHeight-border, true)
}

function DebugPrintDeck(_deck) {
	array_foreach(_deck, function(_element, _index){
		show_debug_message(string(_index) + ": " + string(_element))
	})
	show_debug_message("")
}