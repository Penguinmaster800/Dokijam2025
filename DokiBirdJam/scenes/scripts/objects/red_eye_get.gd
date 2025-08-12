extends Control


func _on_red_eye_get_button_pressed() -> void:
	Abilities.obtain_ability("Red Eye")
	Abilities.red_eye_learned = true
	next_level()


func next_level():
	if Status.level == 2:
		TransitionLayer.change_scene("res://scenes/levels/level_2_main.tscn")
	if Status.level == 3:
		TransitionLayer.change_scene("res://scenes/levels/level_3_main.tscn")
	if Status.level == 4:
		TransitionLayer.change_scene("res://scenes/menus/main_menu.tscn")
