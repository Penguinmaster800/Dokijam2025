extends Area2D
class_name EnvObjectParent

@export var max_health: int
var health: int
var row_no: EnumRowNo.RowNo

var is_wet: bool = false
var is_shocked: bool = false

func _ready() -> void:
	health = max_health
	Abilities.red_eye_cover_change.connect(_red_eye_target)
	

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if not event.is_action_pressed("primary action"):
		return
	
	if Status.doki_ammo <= 0:
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

func _red_eye_target():
	if Abilities.red_eye_cover == true:
		$".".modulate = Color(0.776, 0.066, 0.089)
	if Abilities.red_eye_cover == false:
		$".".modulate = Color(1.0, 1.0, 1.0)

func handle_damage() -> void:
	var _damage: int = 1

	health = health - _damage
	
	if health <= 0:
		handle_destroyed()

func handle_destroyed() -> void:
	queue_free()
