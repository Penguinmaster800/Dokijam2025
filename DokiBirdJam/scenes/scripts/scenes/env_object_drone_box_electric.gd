extends EnvObjectParent
class_name ElectricDroneBox
const DroneBoxStatus = EnumEnvObjectDroneBoxStatus.DroneBoxStatus
var current_stance: DroneBoxStatus = DroneBoxStatus.SPAWN
var drop_destination: Vector2
var drop_speed: int = 1000

signal shock

func _process(delta: float) -> void:
	if current_stance != DroneBoxStatus.DROPPED:
		return
		
	if abs(position.y - drop_destination.y) < 0.1:
		current_stance = DroneBoxStatus.ON_GROUND
		return

	position.y = move_toward(position.y, drop_destination.y, drop_speed * delta)

func handle_destroyed() -> void:
	shock.emit(row_no, global_position, is_shocked)
	super.handle_destroyed()
