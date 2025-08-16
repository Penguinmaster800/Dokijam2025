extends EnvObjectParent

func handle_destroyed() -> void:
	$AnimationPlayer.play("destroyed")
	object_destroyed.emit(object_type, row_no, global_position, is_shocked, is_wet)
