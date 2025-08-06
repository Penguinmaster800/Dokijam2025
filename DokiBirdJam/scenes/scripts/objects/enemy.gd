extends CharacterBody2D

enum Stance {SPAWN, COVER, ATTACK, DEATH}

## Max Health of the Enemy
var max_health: int = 10
## Current Health of the Enemy
var health: int = max_health

## Position to move on spawn
var spawn_move_position: Vector2 = Vector2(640, 360)
## Flag of Destination Reached
var _reached_spawn_move_position: bool = false
## Speed of movement
var movement_speed: int = 100

## Current Stance of the Enemy
var current_stance: Stance = Stance.SPAWN

## Fire Rate of the Attack
var fire_rate: float = 0.5
## Max Ammo
var max_ammo: int = 6
## Current Ammo
var current_ammo: int = max_ammo
## Reload Time
var reload_time: float = 4.0
## Reloading State
var _is_reloading: bool = false

## Signal for Death of the Enemy
signal enemy_death
## Signal for Enemy Reaching the Position
signal enemy_reached_position
## Signal for Attack of the Enemy
signal enemy_attack

func _process(delta: float) -> void:
	
	#var direction = Input.get_vector("left", "right", "up", "down")
	#velocity = direction * 500
	#move_and_slide()
	
	if !_reached_spawn_move_position:
		after_spawn(delta)

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

func after_spawn(delta):
	# Move to position
	position += position.direction_to(spawn_move_position) * movement_speed * delta
	if position.distance_to(spawn_move_position) < 1.0:
		print("Reached Position!")
		_reached_spawn_move_position = true
		enemy_reached_position.emit()
		switch_stance()

func switch_stance():
	match current_stance:
		Stance.SPAWN:
			stance_to_cover()
		Stance.COVER:
			stance_to_attack()
		Stance.ATTACK:
			stance_to_cover()
		Stance.DEATH:
			return

func stance_to_cover():
	var min_cover_time: float = 2.0
	
	if _is_reloading:
		min_cover_time = reload_time
	
	var random_time = randf_range(min_cover_time, 5.0)
	print("Cover: %s seconds" % random_time)
	$TimerCurrentStance.start(random_time)
	current_stance = Stance.COVER
	$AnimationPlayer.play("cover")
	$TimerFireRate.stop()
	
	if _is_reloading:
		current_ammo = max_ammo
		print("Enemy Reloaded! Current Ammo: %s" % current_ammo)
		_is_reloading = false

func stance_to_attack():
	var random_time = randf_range(2.0, 7.0)
	print("Attack: %s seconds" % random_time)
	$TimerCurrentStance.start(random_time)
	current_stance = Stance.ATTACK
	$AnimationPlayer.play("attack")
	$TimerFireRate.start(fire_rate)

func attack():
	enemy_attack.emit()
	current_ammo -= 1
	print("Enemy Fired! Current ammo: %s" % current_ammo)
	
	if current_ammo <= 0:
		_is_reloading = true
		switch_stance()

func death():
	current_stance = Stance.DEATH
	# Wait few seconds for deletion
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

func _on_timer_current_stance_timeout() -> void:
	switch_stance()

func _on_timer_fire_rate_timeout() -> void:
	if current_stance != Stance.ATTACK:
		return
		
	attack()
