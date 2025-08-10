extends Node2D

@export var origin_position: Vector2
@export var target_position: Vector2
@onready var line_2d: Line2D = $Line2D
var is_aiming: bool = false
var player: Node2D = null
var enemy: EnemySniper = null

func _ready() -> void:
	line_2d.visible = false

func _process(delta: float) -> void:
	if is_aiming and enemy:
		var bullet_start_position: Vector2 = enemy.get_node("BulletStartPosition").get_node("Marker2D").global_position
		origin_position = bullet_start_position
		line_2d.points[0] = origin_position
		
		#if Status.in_cover == false:
		target_position = player.global_position
		line_2d.points[1] = target_position

func start_aiming(pos: Vector2) -> void:
	origin_position = pos
	is_aiming = true
	line_2d.visible = true

func stop_aiming() -> void:
	is_aiming = false
	line_2d.visible = false
