extends Area2D
class_name EnvObjectParent

@export var max_health: int
var health: int

func _ready() -> void:
	health = max_health

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if not event.is_action_pressed("primary action"):
		return
	
	if Status.doki_ammo <= 0:
		return
	if Status.in_cover == true:
		return
	if Status.doki_reloading == true:
		return
	
	handle_damage()

func handle_damage() -> void:
	var _damage: int = 1

	health = health - _damage
	
	if health <= 0:
		handle_destroyed()

func handle_destroyed() -> void:
	queue_free()
