extends EnvObjectParent

const DroneBoxStatus = EnumEnvObjectDroneBoxStatus.DroneBoxStatus
var current_stance: DroneBoxStatus = DroneBoxStatus.SPAWN
var drop_destination: Vector2
var drop_speed: int = 1000

signal explode

func _process(delta: float) -> void:
	if current_stance != DroneBoxStatus.DROPPED:
		return
		
	if abs(position.y - drop_destination.y) < 3.0:
		current_stance = DroneBoxStatus.ON_GROUND
		return

	position.y += drop_speed * delta

func handle_destroyed() -> void:
	explode.emit(row_no, global_position)
	super.handle_destroyed()
