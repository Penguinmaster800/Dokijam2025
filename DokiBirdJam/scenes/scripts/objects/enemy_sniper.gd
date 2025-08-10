extends EnemyParent
class_name EnemySniper

var is_aiming: bool = false

signal aiming(pos: Vector2)
signal stop_aiming

func stance_to_attack():
	super.stance_to_attack()
	aiming.emit($BulletStartPosition/Marker2D.global_position)

func stance_attack_cooldown():
	super.stance_attack_cooldown()
	stop_aiming.emit()
