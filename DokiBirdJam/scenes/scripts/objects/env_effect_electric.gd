extends EnvEffectParent

var electric_radius: float = 50.0
var electric_height: float = 200.0

func _ready() -> void:
	_set_collision_circle()
	$Timer.start()

func _set_collision_circle() -> void:
	var col_shape: CapsuleShape2D = $CollisionShape2D.shape
	col_shape.radius = electric_radius
	col_shape.height = electric_height
	$CollisionShape2D.rotation_degrees = 90

func _on_area_entered(area: Area2D) -> void:
	var enemy_node = super.get_entered_enemy_node(area)
	if enemy_node:
		enemy_node.is_shocked = true
		print("Enemy is shocked")
		return

	var object_node = super.get_entered_object_node(area)
	if object_node:
		object_node.is_shocked = true
		return
