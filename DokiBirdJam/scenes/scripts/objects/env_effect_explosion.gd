extends EnvEffectExplosion

var row_no: EnumRowNo.RowNo
var rad: int = 200
@export var col: Color = Color(255, 0, 255)

func _ready() -> void:
	_set_collison_circle()
	_draw()
	$Timer.start()

func _set_collison_circle() -> void:
	var col_shape = $CollisionShape2D.shape
	col_shape.radius = rad

func _draw() -> void:
	var cen = Vector2.ZERO
	draw_circle(cen, rad, col)

func _on_timer_timeout() -> void:
	queue_free()

func _on_area_entered(area: Area2D) -> void:
	var enemy_node = area.get_parent()
	if not (enemy_node is EnemyParent):
		return

	var row_node = enemy_node.get_parent().get_parent()
	if not (row_node is RowParent):
		return
		
	var enemy_row_no = row_node.row_no
	if row_no != enemy_row_no:
		return
	
	if area.name != "Hitbox":
		return
		
	enemy_node.handle_damage()
