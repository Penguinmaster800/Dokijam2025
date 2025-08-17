extends Node2D

func _ready():
	Abilities.ability1 = null
	Abilities.ability2 = null
	Abilities.ability3 = null

	AudioManager.level_one_music.stop()
	AudioManager.level_two_music.stop()
	AudioManager.level_three_music.stop()
	AudioManager.game_over_music.play()

func _on_retry_button_pressed() -> void:
	match Status.level:
		1:
			TransitionLayer.change_scene("res://scenes/levels/level_1_intro.tscn")
		2:
			TransitionLayer.change_scene("res://scenes/levels/level_2_main.tscn")
		3:
			TransitionLayer.change_scene("res://scenes/levels/level_3_main.tscn")

func _on_main_menu_button_pressed() -> void:
	TransitionLayer.change_scene("res://scenes/menus/main_menu.tscn")
