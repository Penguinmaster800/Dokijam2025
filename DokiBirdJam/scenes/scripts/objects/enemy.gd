extends CharacterBody2D

var pos: Vector2 = Vector2.ZERO
const speed: int = 200
var can_laser: bool = true
var can_grenade: bool = true

func _process(_delta: float) -> void:
	
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * 500
	move_and_slide()
	
	## laser shooting input
	#if Input.is_action_pressed("primary action") and can_laser:
		#print("shoot laser")
		#can_laser = false
		#$TimerLaser.start()
	#
	#if Input.is_action_pressed("secondary action") and can_grenade:
		#print("shoot grenade")
		#can_grenade = false
		#$TimerGrenade.start()

func _on_timer_laser_timeout() -> void:
	can_laser = true

func _on_timer_grenade_timeout() -> void:
	can_grenade = true

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	print("Input!")
