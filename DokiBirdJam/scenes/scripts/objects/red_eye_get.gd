extends Control


func _on_red_eye_get_button_pressed() -> void:
	Abilities.obtain_ability("Red Eye")
	Abilities.red_eye_learned = true
	hide_selections()

func hide_selections():
	get_parent().vanish()
