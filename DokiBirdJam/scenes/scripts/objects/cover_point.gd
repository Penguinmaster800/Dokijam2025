extends Node2D

const CoverPointDataScript = preload("res://scenes/scripts/objects/cover_point_data.gd")
var data: CoverPointData

func _ready() -> void:
	var in_cover_positions = set_marker_positions($InCover)
	var out_of_cover_positions = set_marker_positions($OutOfCover)
	data = CoverPointData.new(in_cover_positions, out_of_cover_positions)

func set_marker_positions(node: Node) -> Array[Vector2]:
	
	if node == null:
		return []
	
	var positions: Array[Vector2] = []
	
	for childNode in node.get_children():
		if childNode is Marker2D:
			positions.append(childNode.global_position)
	return positions
