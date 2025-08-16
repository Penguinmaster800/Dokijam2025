extends Control


func _on_health_button_pressed() -> void:
	Status.doki_max_health += 4
	hide_selections()

func hide_selections():
	get_parent().vanish()
