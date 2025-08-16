extends EnvObjectParent
class_name DroneBox
const DroneBoxStatus = EnumEnvObjectDroneBoxStatus.DroneBoxStatus
var current_stance: DroneBoxStatus = DroneBoxStatus.SPAWN
var drop_destination: Vector2
var drop_speed: int = 1000


signal explode


func _process(delta: float) -> void:
	if current_stance != DroneBoxStatus.DROPPED:
		return
		
	if abs(position.y - drop_destination.y) < 0.1:
		current_stance = DroneBoxStatus.ON_GROUND
		return

	position.y = move_toward(position.y, drop_destination.y, drop_speed * delta)

func handle_destroyed() -> void:
	explode.emit(row_no, global_position, is_shocked)
	super.handle_destroyed()
