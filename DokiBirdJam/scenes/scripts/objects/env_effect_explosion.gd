extends EnvEffectParent

var is_shocked = false

var rad: int = 200
@export var col: Color = Color(255, 0, 255)

func _ready() -> void:
	_set_collison_circle()
	AudioManager.dgj_explosion_fixed.play()
#	queue_redraw()
	$AnimatedSprite2D.play()
	await $AnimatedSprite2D.animation_finished
	queue_free()
	#$Timer.start()

func _set_collison_circle() -> void:
	var col_shape = $CollisionShape2D.shape
	col_shape.radius = rad

#func _draw() -> void:
#	var cen = Vector2.ZERO
#	draw_circle(cen, rad, col)

func _on_area_entered(area: Area2D) -> void:
	var object_node = get_entered_object_node(area)
	if object_node:
		object_node.handle_damage()
		return

	var enemy_node = get_entered_enemy_node(area)
	if area.name != "Hitbox" and enemy_node:
		enemy_node.handle_damage(5)
		return
		
func get_entered_enemy_node(area) -> EnemyParent:
	var sprite = area.get_parent()
	if !sprite:
		return null
	var enemy_node = sprite.get_parent()
	if not (enemy_node is EnemyParent):
		return null
	if !is_shocked:
		enemy_node = super.get_entered_enemy_node(area)
	return enemy_node
	
func get_entered_object_node(area) -> EnvObjectParent:
	var object_node = area
	if not (area is EnvObjectParent):
		return null
	if !is_shocked:
		object_node = super.get_entered_object_node(area)
	return object_node
