extends EnvEffectParent

var is_wet = false
var is_shocked = false:
	set(value):
		is_shocked = value
		if is_shocked == true:
			$AnimatedSprite2D.visible = true
			$AnimatedSprite2D.play()


var puddle_radius: float = 150.0
var puddle_height: float = 75.0
@export var water_color: Color = Color(0, 0.5, 1, 0.3)

func _ready() -> void:
	_set_collision_circle()
	queue_redraw()
	AudioManager.water_explode.play()
	$Timer.start()

func _set_collision_circle() -> void:
	var col_shape: CapsuleShape2D = $CollisionShape2D.shape
	col_shape.radius = puddle_radius
	col_shape.height = puddle_height
	$CollisionShape2D.rotation_degrees = 90

func _draw() -> void:
	var cen = Vector2.ZERO
	draw_circle(cen, puddle_radius-50, water_color)

func _on_area_entered(area: Area2D) -> void:
	var object_node = get_entered_object_node(area)
	var enemy_node = get_entered_enemy_node(area)
	if is_shocked == false:
		if object_node:
			object_node.is_wet = true
			return
		if  enemy_node:
			enemy_node.is_wet = true
			print("enemy_node is wet")
			return
	if is_shocked == true:
		if object_node:
			object_node.is_wet = true
			object_node.is_shocked = true
			return
		if  enemy_node:
			enemy_node.is_wet = true
			enemy_node.is_shocked = true
			print("enemy_node is wetand shocked")
		var env_effect_water = super.get_entered_env_node(area)
		if env_effect_water: 
			env_effect_water.is_shocked = true
			print("shocked water")

func get_entered_enemy_node(area) -> EnemyParent:
	var sprite = area.get_parent()
	if !sprite:
		return null
	var enemy_node = sprite.get_parent()
	if (enemy_node is EnemyParent and EnemyStationary):
		return enemy_node
	if not (enemy_node is EnemyParent or EnemyStationary):
		return null
	if !is_wet:
		enemy_node = super.get_entered_enemy_node(area)
	return enemy_node

func get_entered_object_node(area) -> EnvObjectParent:
	var object_node = area
	if not (area is EnvObjectParent):
		return null
	if !is_wet:
		object_node = super.get_entered_object_node(area)
	return object_node
