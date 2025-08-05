extends CharacterBody2D

## Max Health of the Enemy
var max_health: int = 10
## Current Health of the Enemy
var health: int = max_health

## Signal for Death of the Enemy
signal enemy_death

func _process(_delta: float) -> void:
	
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * 500
	move_and_slide()
	
func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if not event.is_action("primary action"):
		return
	
	if health <= 0:
		return

	# TODO: Temporary variable for Damage. Replace Later.
	var _damage: int = 1

	health = health - _damage
	print("Hit! Current Health: %s" % health)
	
	if health == 0:
		death()

func death():
	# Wait few seconds
	var deletion_timer = get_tree().create_timer(3)

	# Play animation
	$AnimationPlayer.play("death")
	# Await for animation to end
	await $AnimationPlayer.animation_finished
	# Emit Death Signal
	enemy_death.emit()
	
	# Remove itself
	await deletion_timer.timeout
	queue_free()
