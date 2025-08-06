extends StaticBody2D

var speed: int = 1000
var destination: Vector2 = Vector2.ZERO
var direction: Vector2 = Vector2.DOWN

func _process(delta: float) -> void:
	if position.distance_to(destination) <= 10:
		queue_free()
		
	var velocity = position.direction_to(destination)
	$Sprite2D.rotation = velocity.angle() + PI/2
	position += velocity * speed * delta
