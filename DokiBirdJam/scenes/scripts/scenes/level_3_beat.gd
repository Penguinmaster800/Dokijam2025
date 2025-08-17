extends Node2D

func _ready():
	AudioManager.level_three_music.stop()
	AudioManager.victory_music.play()

func _on_button_pressed() -> void:
	TransitionLayer.change_scene("res://scenes/menus/credits.tscn")

func _on_main_menu_button_pressed() -> void:
	TransitionLayer.change_scene("res://scenes/menus/main_menu.tscn")
