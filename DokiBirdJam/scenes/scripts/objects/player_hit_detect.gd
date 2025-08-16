extends Area2D

func _on_body_entered(body: Node):
	var damage = body.damage
	if Abilities.going_ghost_active == false:
		#add sound for getting hit
		Status.doki_health -= damage
		$"../AnimationPlayer".play("HitFlash")
		print(Status.doki_health)
		body.queue_free()
	if Abilities.going_ghost_active == true:
		body.queue_free()
