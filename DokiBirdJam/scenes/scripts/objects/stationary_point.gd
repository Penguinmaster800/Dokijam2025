extends Node2D
const StationaryPointDataScript = preload("res://scenes/scripts/objects/stationary_point_data.gd")
var data: StationaryPointData

func _ready() -> void:
	var stationary_point_positions = set_marker_positions($".")
	data = StationaryPointData.new(stationary_point_positions)

func set_marker_positions(node: Node) -> Array[Vector2]:
	
	if node == null:
		return []
	
	var positions: Array[Vector2] = []
	
	for childNode in node.get_children():
		if childNode is Marker2D:
			positions.append(childNode.global_position)
	return positions
