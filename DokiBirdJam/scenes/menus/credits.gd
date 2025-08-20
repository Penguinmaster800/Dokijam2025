extends Control


func _ready():
	AudioManager.main_menu_music.stop()
	AudioManager.thank_you_for_playing_credits_.play()


func _on_label_3_meta_clicked(meta: Variant) -> void:
	OS.shell_open(str(meta))
