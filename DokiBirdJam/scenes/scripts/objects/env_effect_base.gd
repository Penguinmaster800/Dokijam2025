extends Area2D
class_name EnvEffectParent

var row_no: EnumRowNo.RowNo

func _on_area_entered(area: Area2D) -> void:
	get_entered_object_node(area)
	get_entered_enemy_node(area)

func get_entered_enemy_node(area: Area2D) -> EnemyParent:
	var sprite = area.get_parent()
	if !sprite:
		return null
		
	var enemy_node = sprite.get_parent()
	if not (enemy_node is EnemyParent):
		return null
	
	var row_node = enemy_node.get_parent().get_parent()
	if not (row_node is RowParent):
		return null
	
	var enemy_row_no = row_node.row_no
	if row_no > enemy_row_no +1 or row_no < enemy_row_no -1:
		return null

	return enemy_node

func get_entered_object_node(area: Area2D) -> EnvObjectParent:
	if not (area is EnvObjectParent):
		return

	var row_node = area.get_parent().get_parent()
	if not (row_node is RowParent):
		return

	var object_row_no = row_node.row_no
	if row_no != object_row_no:
		return

	return area


func _on_timer_timeout() -> void:
	queue_free()
