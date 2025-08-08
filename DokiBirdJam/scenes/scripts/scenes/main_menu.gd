extends Control

func _on_play_button_pressed() -> void:
	TransitionLayer.change_scene("res://scenes/levels/level_1_intro.tscn")

func _on_settings_button_pressed() -> void:
	TransitionLayer.change_scene("res://scenes/menus/settings.tscn")

func _on_exit_button_pressed() -> void:
	get_tree().quit()

func _on_credits_button_pressed() -> void:
	TransitionLayer.change_scene("res://scenes/menus/credits.tscn")
