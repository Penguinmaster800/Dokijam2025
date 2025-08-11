extends Area2D

func _on_body_entered(body: Node):
	
	var damage = body.damage
	
	#add sound for getting hit
	Status.doki_health -= damage
	print(Status.doki_health)
	body.queue_free()
