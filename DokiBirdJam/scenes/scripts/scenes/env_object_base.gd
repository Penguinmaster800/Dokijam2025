extends Area2D
class_name EnvObjectParent

@export var max_health: int = 1
@export var object_type: EnumEnvObjectType.EnvObjectType

var health: int
var row_no: EnumRowNo.RowNo

var is_wet: bool = false
var is_shocked: bool = false

signal object_destroyed(object_type: EnumEnvObjectType.EnvObjectType, row_no: EnumRowNo.RowNo, pos: Vector2, is_shocked: bool, is_wet: bool)

func _ready() -> void:
	health = max_health
	Abilities.red_eye_cover_change.connect(_red_eye_target)
	
	var level = _find_level_parent(get_tree().current_scene)
	if level:
		object_destroyed.connect(level._on_env_object_destroyed)

func _find_level_parent(node: Node) -> LevelParent:
	if node is LevelParent:
		return node
	for child in node.get_children():
		var result = _find_level_parent(child)
		if result:
			return result
	return null

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if not event.is_action_pressed("primary action"):
		return
	
	if Status.doki_ammo <= 0 and Status.last_bullet == false:
		return
	if Status.doki_ammo < 0:
		return
	if Status.in_cover == true:
		return
	if Status.doki_exposed == false:
		return
	if Status.doki_reloading == true:
		return
	if Status.doki_shot_cooldown == true:
		return
	
	handle_damage()
	if Status.doki_ammo == 0:
		Status.last_bullet = false

func _red_eye_target():
	if Abilities.red_eye_cover == true:
		$".".modulate = Color(0.776, 0.066, 0.089)
	if Abilities.red_eye_cover == false:
		$".".modulate = Color(1.0, 1.0, 1.0)

func handle_damage() -> void:
	if health <= 0:
		return
	
	var _damage: int = 1

	health = health - _damage
	
	if health <= 0:
		handle_destroyed()

func handle_destroyed() -> void:
	#if object_type == EnumEnvObjectType.EnvObjectType.EXPLOSIVES:
	#	$BaseAnimationPlayer.play("explosion")
	#	await $BaseAnimationPlayer.animation_finished
	object_destroyed.emit(object_type, row_no, global_position, is_shocked, is_wet)
	queue_free()
