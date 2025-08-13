extends Control


func _on_health_button_pressed() -> void:
	Status.doki_max_health += 4
	next_level()


func next_level():
	if Status.level == 1:
		TransitionLayer.change_scene("res://scenes/levels/level_1_main.tscn")
	if Status.level == 2:
		TransitionLayer.change_scene("res://scenes/levels/level_2_main.tscn")
	if Status.level == 3:
		TransitionLayer.change_scene("res://scenes/levels/level_3_main.tscn")
	if Status.level == 4:
		TransitionLayer.change_scene("res://scenes/menus/main_menu.tscn")
