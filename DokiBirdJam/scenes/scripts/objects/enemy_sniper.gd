extends EnemyParent
class_name EnemySniper

signal aiming(pos: Vector2)
signal stop_aiming

func _process(delta: float) -> void:
	super._process(delta)
	
	if current_stance == Stance.ATTACK:
		if not Status.in_cover:
			if $TimerCanShoot.is_stopped():
				$TimerCanShoot.start()
		else:
			$TimerCanShoot.stop()

func stance_to_attack():
	super.stance_to_attack()
	aiming.emit($BulletStartPosition/Marker2D.global_position)

func stance_attack_cooldown():
	$TimerCanShoot.stop()
	super.stance_attack_cooldown()
	stop_aiming.emit()

func attack():
	pass

func _on_timer_can_shoot_timeout() -> void:
	super.attack()
