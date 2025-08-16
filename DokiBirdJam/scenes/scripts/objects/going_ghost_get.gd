extends Control


func _on_ghost_get_button_pressed() -> void:
	Abilities.obtain_ability("Going Ghost")
	Abilities.going_ghost_learned = true
	hide_selections()

func hide_selections():
	get_parent().vanish()
