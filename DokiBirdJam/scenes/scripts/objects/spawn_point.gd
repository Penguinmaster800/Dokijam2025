extends Node2D
const SpawnPointDataScript = preload("res://scenes/scripts/objects/spawn_point_data.gd")
var data: SpawnPointData

func _ready() -> void:
	var spawn_positions = set_marker_positions($".")
	data = SpawnPointData.new(spawn_positions)

func set_marker_positions(node: Node) -> Array[Vector2]:
	
	if node == null:
		return []
	
	var positions: Array[Vector2] = []
	
	for childNode in node.get_children():
		if childNode is Marker2D:
			positions.append(childNode.global_position)
	return positions
