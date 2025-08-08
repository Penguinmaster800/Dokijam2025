extends Node2D

var cover_points: Array[CoverPointData]
var spawn_points: Array[SpawnPointData]

func _ready() -> void:
	var cover_point_nodes = $CoverPoints.get_children()
	
	for cover_point_node in cover_point_nodes:
		cover_points.append(cover_point_node.data)
	
	var spawn_point_nodes = $SpawnPoints.get_children()
	
	for spawn_point_node in spawn_point_nodes:
		spawn_points.append(spawn_point_node.data)
