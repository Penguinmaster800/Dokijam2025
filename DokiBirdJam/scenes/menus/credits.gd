extends Control


func _ready():
	AudioManager.main_menu_music.stop()
	AudioManager.thank_you_for_playing_credits_.play()
