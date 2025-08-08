class_name CoverPointData

var in_cover_positions: Array[Vector2]
var out_of_cover_positions: Array[Vector2]
var is_available: bool

func _init(in_pos: Array[Vector2], out_pos: Array[Vector2]):
	in_cover_positions = in_pos
	out_of_cover_positions = out_pos
	is_available = true
