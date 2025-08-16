extends Node2D
func _ready():
	Abilities.going_ghost_learned = false
	Abilities.red_eye_learned = false
	Abilities.going_ghost_learned = false
	Abilities.ability1 = null
	Abilities.ability2 = null
	Abilities.ability3 = null
	Status.doki_max_ammo = 6
	Status.doki_max_health = 10
	AudioManager.game_over_music.stop()
	AudioManager.main_menu_music.stop()
	AudioManager.intermission_music.play()

func _on_button_pressed() -> void:
	TransitionLayer.change_scene("res://scenes/levels/level_1_main.tscn")
