extends EnvObjectParent

signal shock

func handle_destroyed() -> void:
	print("Shock Handled!")
	shock.emit(row_no, global_position, is_shocked)
	super.handle_destroyed()
