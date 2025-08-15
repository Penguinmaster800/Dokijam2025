extends Node2D
class_name RowParent

var cover_points: Array[CoverPointData]
var spawn_points: Array[SpawnPointData]
var stationary_points: Array[StationaryPointData]
@export var row_no: EnumRowNo.RowNo

func _ready() -> void:
	var cover_point_nodes = $CoverPoints.get_children()
	
	for cover_point_node in cover_point_nodes:
		cover_points.append(cover_point_node.data)
	
	var spawn_point_nodes = $SpawnPoints.get_children()
	
	for spawn_point_node in spawn_point_nodes:
		spawn_points.append(spawn_point_node.data)
	
	var stationary_point_nodes = $StationaryPoints.get_children()

	for stationary_point_node in stationary_point_nodes:
		stationary_points.append(stationary_point_node.data)

func get_available_cover_points() -> Array[CoverPointData]:
	var available_points: Array[CoverPointData] = []
	
	for cover_point in cover_points:
		if cover_point.is_available:
			available_points.append(cover_point)
	return available_points

func has_available_cover_points() -> bool:
	return get_available_cover_points().size() > 0
