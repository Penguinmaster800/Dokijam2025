extends Node2D
class_name EnemyParent

enum Stance {SPAWN, COVER, MOVE_TO_ATTACK, ATTACK, ATTACK_COOLDOWN, DEATH}

@onready var hit_flash_animation_player = $HitFlashAnimationPlayer

## Max Health of the Enemy
@export var max_health: int = 10
## Current Health of the Enemy
var health: int

## Environmental Status Effects
var is_wet: bool = false
var is_shocked: bool = false

## Cover Position Data
var cover_point: CoverPointData
## Flag of In Cover Reached
var _reached_in_cover_position: bool = true
var _reached_out_of_cover_position: bool = true
var current_cover_destination: Vector2

## Position to move on spawn
var spawn_move_position: Vector2 = Vector2(640, 360)
## Flag of Destination Reached
var _reached_spawn_move_position: bool = false
## Speed of movement
@export var movement_speed: int = 100


## Current Stance of the Enemy
var current_stance: Stance = Stance.SPAWN

## Weapon Type
@export var attack_type: EnemyAttackType.AttackType = EnemyAttackType.AttackType.NORMAL
## Fire Rate of the Attack
@export var fire_rate: float = 0.5
## Max Ammo
@export var max_ammo: int = 6
## Current Ammo
var current_ammo: int
## Reload Time
@export var reload_time: float = 4.0
## Reloading State
var _is_reloading: bool = false
## Cooldown time before going to Cover
var attack_cooldown_time: float = 1.2
var move_out_of_cover_time: float = 1.2

## Scaling enemy sizes
var min_y: float = 150.0
var max_y: float = 550.0
var min_scale: float = 0.5
var max_scale: float = 1.0

var calculated_scale: float = 1.0

var attack_sound := [AudioManager.enemy_shot_1, AudioManager.enemy_shot_2]
var random_attack_sound = attack_sound.pick_random()

## Signal for Death of the Enemy
signal enemy_death
## Signal for Enemy Reaching the Position
signal enemy_reached_position
## Signal for Attack of the Enemy
signal enemy_attack(pos, type)

func _ready() -> void:
	health = max_health
	current_ammo = max_ammo
	set_scale_from_position()
	Abilities.aim_bot_activate.connect(_aim_bot_target)
	Abilities.red_eye_cover_change.connect(_red_eye_target)
	$AnimationPlayer.play("Run")
	if spawn_move_position.x < global_position.x:
		scale.x = -abs(calculated_scale)

func _process(delta: float) -> void:

	if current_stance == Stance.DEATH:
		return

	if !_reached_spawn_move_position:
		after_spawn(delta)
	
	if !_reached_in_cover_position:
		move_to_cover(delta)
	
	if !_reached_out_of_cover_position:
		move_out_of_cover(delta)

func set_scale_from_position() -> void:
	var clamped = clamp(position.y, min_y, max_y)
	var normalized_position = (clamped - min_y) / (max_y - min_y)
	calculated_scale = min_scale + (normalized_position * (max_scale - min_scale))
	scale = Vector2(calculated_scale, calculated_scale)

func _on_hitbox_head_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if not event.is_action_pressed("primary action"):
		return
	
	if Status.doki_ammo <= 0:
		return
	if Status.in_cover == true:
		return
	if Status.doki_reloading == true:
		return
	handle_damage(2)
	#add sound from headshot
	get_viewport().set_input_as_handled()

func _on_hitbox_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
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
	#add basic hit sound
	handle_damage()

func _aim_bot_target():
	if current_stance != Stance.COVER or Abilities.red_eye_cover == true:
		handle_damage(3)

func _red_eye_target():
	if Abilities.red_eye_cover == true:
		$".".modulate = Color(0.776, 0.066, 0.089)
	if Abilities.red_eye_cover == false:
		$".".modulate = Color(1.0, 1.0, 1.0)

func handle_damage(multiplier: int = 1):
	
	if health <= 0:
		return
	
	# TODO: Remove this. Might be useful for Abilities.
	#if current_stance == Stance.COVER:
		#return

	# TODO: Temporary variable for Damage. Replace Later.
	var _damage: int = 1
	_damage = _damage * multiplier

	health = health - _damage
	hit_flash_animation_player.play("HitFlash")
	
	if health <= 0:
		death()

func after_spawn(delta):
	# Move to position
	position += position.direction_to(spawn_move_position) * movement_speed * delta
	if position.distance_to(spawn_move_position) < 3.0:
		_reached_spawn_move_position = true
		enemy_reached_position.emit()
		switch_stance()
		scale.x = abs(calculated_scale)

func move_to_cover(delta):
	# Move to position
	var in_cover_pos = cover_point.in_cover_positions[0]
	position += position.direction_to(in_cover_pos) * movement_speed * delta
	if position.distance_to(in_cover_pos) < 3.0:
		_reached_in_cover_position = true
		switch_stance()

func move_out_of_cover(delta):
	# Move to position
	position += position.direction_to(current_cover_destination) * movement_speed * delta
	if position.distance_to(current_cover_destination) < 3.0:
		_reached_out_of_cover_position = true
		switch_stance()

func switch_stance():
	match current_stance:
		Stance.SPAWN:
			stance_to_cover()
		Stance.COVER:
			stance_move_to_attack()
		Stance.MOVE_TO_ATTACK:
			stance_to_attack()
		Stance.ATTACK:
			stance_attack_cooldown()
		Stance.ATTACK_COOLDOWN:
			stance_to_cover()
		Stance.DEATH:
			return

func stance_move_to_attack():
	current_cover_destination = cover_point.out_of_cover_positions.pick_random()
	current_stance = Stance.MOVE_TO_ATTACK
	_reached_out_of_cover_position = false

func stance_attack_cooldown():
	#$TimerCurrentStance.start(attack_cooldown_time)
	current_stance = Stance.ATTACK_COOLDOWN
	_reached_in_cover_position = false
	$TimerFireRate.stop()

func stance_to_cover():
	var min_cover_time: float = 2.0
	
	if _is_reloading:
		min_cover_time = reload_time
	
	var random_time = randf_range(min_cover_time, 5.0)
	$TimerCurrentStance.start(random_time)
	current_stance = Stance.COVER
	$AnimationPlayer.play("Hide")
	
	if _is_reloading:
		current_ammo = max_ammo
		_is_reloading = false

func stance_to_attack():
	var random_time = randf_range(2.0, 7.0)
	$TimerCurrentStance.start(random_time)
	current_stance = Stance.ATTACK
	$AnimationPlayer.play("Aim")
	$AnimationPlayer.queue("Attack")
	$TimerFireRate.start(fire_rate)

func attack():
	enemy_attack.emit($BulletStartPosition/Marker2D.global_position, attack_type)
	current_ammo -= 1
	random_attack_sound = attack_sound.pick_random()
	random_attack_sound.play()
	if current_ammo <= 0:
		_is_reloading = true
		stance_attack_cooldown()

func death():
	current_stance = Stance.DEATH
	# Wait few seconds for deletion
	var deletion_timer = get_tree().create_timer(3)

	# Play animation
	$AnimationPlayer.play("Death")
	AudioManager.enemy_death.play()
	# Await for animation to end
	await $AnimationPlayer.animation_finished
	# Emit Death Signal
	Status.enemies_remaining -= 1
	print(Status.enemies_remaining)
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

func apply_effect_wet():
	is_wet = true
	$TimerEffectWet.start()
	
	if is_shocked:
		$TimerEffectWetShockDamage.start()

func apply_effect_shocked():
	is_shocked = true
	$TimerEffectShock.start()
	
	if is_wet:
		$TimerEffectWetShockDamage.start()

func _on_timer_effect_wet_timeout() -> void:
	is_wet = false
	$TimerEffectWetShockDamage.stop()

func _on_timer_effect_shock_timeout() -> void:
	is_shocked = false
	$TimerEffectWetShockDamage.stop()

func _on_timer_effect_wet_shock_damage_timeout() -> void:
	if is_wet and is_shocked:
		handle_damage(1)
		$TimerEffectWetShockDamage.start()	
