extends Node2D

func _ready():
	AudioManager.level_one_music.stop()
	AudioManager.intermission_music.play()

func _on_button_pressed() -> void:
	TransitionLayer.change_scene("res://scenes/levels/level_2_main.tscn")
