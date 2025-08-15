extends EnvObjectParent

var movement_speed: float = 100.0
var dest_pos: Vector2

func _process(delta: float) -> void:
	if dest_pos:
		position = position.move_toward(dest_pos, movement_speed * delta)
		if position.distance_to(dest_pos) < 0.1:
			queue_free()
