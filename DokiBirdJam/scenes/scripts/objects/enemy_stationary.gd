extends EnemyParent
class_name EnemyStationary

var stationary_position: StationaryPointData
var _reached_stationary_position: bool = false

func _ready() -> void:
	super._ready()
	if stationary_position.stationary_point_positions[0].x < global_position.x:
		scale.x = abs(calculated_scale)
	else:
		scale.x = -abs(calculated_scale)

func _process(delta: float) -> void:
	if current_stance == Stance.DEATH:
		return
	if !_reached_spawn_move_position:
		after_spawn(delta)

func switch_stance():
	match current_stance:
		Stance.SPAWN:
			stance_to_stationary_attack()
		Stance.ATTACK:
			stance_stationary_attack_cooldown()
		Stance.ATTACK_COOLDOWN:
			stance_to_stationary_attack()
		Stance.DEATH:
			return

func after_spawn(delta):
	var pos = stationary_position.stationary_point_positions[0]
	position = position.move_toward(pos, movement_speed * delta)
	if position.distance_to(pos) < 3.0:
		_reached_stationary_position = true
		_reached_spawn_move_position = true
		enemy_reached_position.emit()
		switch_stance()
		scale.x = abs(calculated_scale)

func stance_to_stationary_attack():
	var random_time = randf_range(2.0, 7.0)
	$TimerCurrentStance.start(random_time)
	current_stance = Stance.ATTACK
	$AnimationPlayer.play("Attack")
	$TimerFireRate.start(fire_rate)

func stance_stationary_attack_cooldown():
	current_stance = Stance.ATTACK_COOLDOWN
	$TimerFireRate.stop()

	if _is_reloading:
		var reload_wait_time = reload_time
		$TimerCurrentStance.start(reload_wait_time)
		$AnimationPlayer.play("Hide")
	else:
		var cooldown_time = randf_range(1.0, 2.0)
		$TimerCurrentStance.start(cooldown_time)
		$AnimationPlayer.play("Hide")

func _on_timer_current_stance_timeout() -> void:
	if current_stance == Stance.ATTACK_COOLDOWN and _is_reloading:
		current_ammo = max_ammo
		_is_reloading = false
	switch_stance()
