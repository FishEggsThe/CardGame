if room != Rm_Menu {
	if winCondition() {
		won = true
	} else {
		won = false
	}
}

if keyboard_check_pressed(vk_enter) {
	debug = !debug
	if debug {
		show_debug_message("************************** Debug Enabled **************************")
	}
}