extends Control



func _on_ammo_button_pressed() -> void:
	Status.doki_max_ammo += 2
	hide_selections()

func hide_selections():
	get_parent().vanish()
