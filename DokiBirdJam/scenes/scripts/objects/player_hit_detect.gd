extends Area2D


func _on_body_entered(body: Node):
	var damage = body.damage
	if Abilities.going_ghost_active == false:
		Status.doki_health -= damage
		_hit_sound()
		$"../AnimationPlayer".play("HitFlash")
		print(Status.doki_health)
		body.queue_free()
	if Abilities.going_ghost_active == true:
		body.queue_free()



func _hit_sound():
	var rng = randi_range(0,9)
	match rng:
		0:
			AudioManager.dgj_doki_injured_1.play()
		1:
			AudioManager.dgj_doki_injured_2.play()
		2:
			AudioManager.dgj_doki_injured_3.play()
		3:
			AudioManager.dgj_doki_injured_4.play()
		4:
			AudioManager.dgj_doki_injured_5_1.play()
		5:
			AudioManager.dgj_doki_injured_6.play()
		6:
			AudioManager.dgj_doki_injured_7.play()
		7:
			AudioManager.dgj_doki_injured_8.play()
		8:
			AudioManager.dgj_doki_injured_9.play()
		9:
			AudioManager.dgj_doki_injured_10.play()
