extends Control

var no_ammo = preload("res://assets/ui/Crosshairs/No Ammo.png")

func _ready():
	Input.set_custom_mouse_cursor(no_ammo, Input.CURSOR_ARROW, Vector2(42, 49))
	Status.doki_max_ammo = 6
	Status.doki_max_health = 10
	AudioManager.game_over_music.stop()
	AudioManager.level_one_music.stop()
	AudioManager.level_two_music.stop()
	AudioManager.level_three_music.stop()
#	AudioManager.
	AudioManager.thank_you_for_playing_credits_.stop()
	if  ! AudioManager.main_menu_music.playing:
		AudioManager.main_menu_music.play()


func _on_play_button_pressed() -> void:
	TransitionLayer.change_scene("res://scenes/levels/level_1_intro.tscn")

func _on_settings_button_pressed() -> void:
	TransitionLayer.change_scene("res://scenes/menus/settings.tscn")

func _on_exit_button_pressed() -> void:
	get_tree().quit()

func _on_credits_button_pressed() -> void:
	TransitionLayer.change_scene("res://scenes/menus/credits.tscn")
