extends Control


func _on_aim_bot_get_button_pressed() -> void:
	Abilities.obtain_ability(Abilities.aim_bot)
	next_level()


func next_level():
	if Status.level == 2:
		TransitionLayer.change_scene("res://scenes/levels/level_2_main.tscn")
	if Status.level == 3:
		TransitionLayer.change_scene("res://scenes/levels/level_3_main.tscn")
	if Status.level == 4:
		TransitionLayer.change_scene("res://scenes/menus/main_menu.tscn")
