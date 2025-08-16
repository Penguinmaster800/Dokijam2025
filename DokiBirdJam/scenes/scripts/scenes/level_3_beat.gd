extends Node2D


func _on_button_pressed() -> void:
	TransitionLayer.change_scene("res://scenes/levels/level_1_main.tscn")

func _on_main_menu_button_pressed() -> void:
	TransitionLayer.change_scene("res://scenes/menus/main_menu.tscn")
