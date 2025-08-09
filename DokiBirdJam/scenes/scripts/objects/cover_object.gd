extends Area2D

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if not event.is_action_pressed("primary action"):
		return
