extends EnvEffectParent

var is_shocked = false

var rad: int = 200
@export var col: Color = Color(255, 0, 255)

func _ready() -> void:
	_set_collison_circle()
	queue_redraw()
	$Timer.start()

func _set_collison_circle() -> void:
	var col_shape = $CollisionShape2D.shape
	col_shape.radius = rad

func _draw() -> void:
	var cen = Vector2.ZERO
	draw_circle(cen, rad, col)

func _on_area_entered(area: Area2D) -> void:
	var enemy_node = area.get_parent()
	var object_node = area
	if not (enemy_node is EnemyParent):
		return
	if ! is_shocked:
		object_node = super.get_entered_object_node(area)
		enemy_node = super.get_entered_enemy_node(area)
		
	if area.name != "Hitbox" and enemy_node:
		enemy_node.handle_damage(5)
		return
		
	if not (area is EnvObjectParent):
		return
		
	if object_node:
		object_node.handle_damage(5)
		return
