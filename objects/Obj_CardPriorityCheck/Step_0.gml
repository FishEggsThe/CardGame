var pressedInput = mouse_check_button_pressed(mb_left)
var releasedInput = mouse_check_button_released(mb_left)
var setAlarm = 8

if pressedInput+releasedInput {
	if (pressedInput && heldCard == noone) {
		var cardPicked = false
		for(var i = 0; i < array_length(cardQueue); i++) {
			if position_meeting(mouse_x, mouse_y, cardQueue[i]) {
				cardPicked = true; alarm[0] = setAlarm
				// Hold selected card
				with cardQueue[i] {
					if cardBelow != noone {
						cardBelow.cardAbove = noone
						cardBelow = noone
					}
					oX = x; oY = y; held = true
					oMouseX = mouse_x; oMouseY = mouse_y
					Obj_CardPriorityCheck.heldCard = id
				}
			
				// Shift priority list
				if i > 0 {
					PrioritizeCard(i)
				}
				break
			}
		}
	
		// Things other than a card
		if !cardPicked {
			with Obj_Deck {
				if position_meeting(mouse_x, mouse_y, id) {
					if array_length(deck) > 0 {
						if mouse_check_button_pressed(mb_left) {
							var currDeckSize = array_length(deck)
							var extraHeight = cardHeight * currDeckSize * heightPixelPercent
							var trueHeight = extraHeight+cardHeight/2
							
							var card = CreateCard(deck[0].symbol, deck[0].number, x, y-trueHeight)
							PlaceCard(x+150, y-cardHeight/2, card, false)
							
							array_delete(deck, 0, 1)
							with Obj_CardPriorityCheck {SetCardDepths()}
						}
					}
				}
			}
		}
	} else if (alarm[0] <= 0 && heldCard != noone) {
		//alarm[0] = setAlarm
		with heldCard {
			held = false
		
			var cardUnder = FindNearestTopCard(id)
			if (cardUnder != noone && cardUnder.cardAbove == noone) {
				var canStack = true
				if !Obj_Control.stackOrder(cardInfo, cardUnder.cardInfo) {canStack = false}
			
				if canStack {
					// Card below placed card
					cardUnder.cardAbove = id
			
					// Card on top
					//cardAbove = noone
					cardBelow = cardUnder
			
					// Positioning placed card over cardUnder nicely
					PlaceCard(cardUnder.x, cardUnder.y, id, true)
				}
			} else if !Obj_Control.freePlace {
				PlaceCard(oX, oY, id, false)
			} else if (Obj_Control.placeInDeck && place_meeting(x, y, Obj_Deck)) {
				var nearestDeck = instance_nearest(x, y, Obj_Deck)
				Obj_Deck.deck = AddToDeck(id, Obj_Deck.deck)
			}
		}
		heldCard = noone
	}
}