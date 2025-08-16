extends Node2D
func _ready():
	Abilities.going_ghost_learned = false
	Abilities.red_eye_learned = false
	Abilities.going_ghost_learned = false
	Abilities.ability1 = null
	Abilities.ability2 = null
	Abilities.ability3 = null
	AudioManager.main_menu_music.stop()
	AudioManager.intermission_music.play()

func _on_button_pressed() -> void:
	TransitionLayer.change_scene("res://scenes/levels/level_1_main.tscn")
