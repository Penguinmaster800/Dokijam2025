extends EnvObjectParent

enum Stance {SPAWN, MOVE_TO_LEFT, MOVE_TO_RIGHT, DESTROYED}
const DroneBoxStatus = EnumEnvObjectDroneBoxStatus.DroneBoxStatus

var position_x_left: int = 200
var position_x_right: int = 1100
var position_y: int = 0
var movement_speed: int = 200
var current_stance: Stance = Stance.SPAWN
@onready var drone_box = $EnvObjectDroneBox

func _ready() -> void:
	var current_x = position.x
	var dist_left = abs(current_x - position_x_left)
	var dist_right = abs(current_x - position_x_right)
	
	if dist_left < dist_right:
		current_stance = Stance.MOVE_TO_RIGHT
	else:
		current_stance = Stance.MOVE_TO_LEFT
	
	drone_box.row_no = row_no

func _process(delta: float) -> void:
	if current_stance == Stance.MOVE_TO_RIGHT:
		if abs(position.x - position_x_right) < 3.0:
			current_stance = Stance.MOVE_TO_LEFT
			return

		position.x += movement_speed * delta
	
	if current_stance == Stance.MOVE_TO_LEFT:
		if abs(position.x - position_x_left) < 3.0:
			current_stance = Stance.MOVE_TO_RIGHT
			return
	
		position.x -= movement_speed * delta

func handle_destroyed() -> void:
	if drone_box:
		var box_global_pos = drone_box.global_position
		var box_sprite = drone_box.get_node("Sprite2D")
		var box_height = box_sprite.texture.get_height() * box_sprite.scale.y
		remove_child(drone_box)

		drone_box.global_position = box_global_pos
		drone_box.drop_destination = global_position
		drone_box.current_stance = DroneBoxStatus.DROPPED
		get_parent().add_child(drone_box)

	super.handle_destroyed()
