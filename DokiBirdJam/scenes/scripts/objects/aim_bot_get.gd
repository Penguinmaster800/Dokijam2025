extends Control


func _on_aim_bot_get_button_pressed() -> void:
	Abilities.obtain_ability("Aim Bot")
	Abilities.aim_bot_learned = true
#	next_level()
	hide_selections()

func hide_selections():
	get_parent().vanish()

#func next_level():
#	if Status.level == 1:
#		TransitionLayer.change_scene("res://scenes/levels/level_1_main.tscn")
#	if Status.level == 2:
#		TransitionLayer.change_scene("res://scenes/levels/level_2_main.tscn")
#		TransitionLayer.change_scene("res://scenes/levels/level_3_main.tscn")
#	if Status.level == 4:
#		TransitionLayer.change_scene("res://scenes/menus/main_menu.tscn")
