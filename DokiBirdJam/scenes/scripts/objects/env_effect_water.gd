extends EnvEffectParent

var puddle_radius: float = 50.0
var puddle_height: float = 200.0
@export var water_color: Color = Color(0, 0.5, 1, 0.6)

func _ready() -> void:
	_set_collision_circle()
	$Timer.start()

func _set_collision_circle() -> void:
	var col_shape: CapsuleShape2D = $CollisionShape2D.shape
	col_shape.radius = puddle_radius
	col_shape.height = puddle_height
	$CollisionShape2D.rotation_degrees = 90

func _on_area_entered(area: Area2D) -> void:
	var enemy_node = super.get_entered_enemy_node(area)
	if enemy_node:
		enemy_node.is_wet = true
		print("Enemy is wet")

	var object_node = super.get_entered_object_node(area)
	if object_node:
		object_node.is_wet = true
		return
