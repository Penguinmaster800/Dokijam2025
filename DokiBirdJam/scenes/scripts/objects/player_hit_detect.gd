extends Area2D





func _on_body_entered(_body):
	#add sound for getting hit
	Status.doki_health -= 1
	print(Status.doki_health)
	_body.queue_free()
