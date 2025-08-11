extends StaticBody2D
class_name EnemyBullet

@export var damage: int = 1
var speed: int = 1500
var destination: Vector2 = Vector2.ZERO
var velocity: Vector2

func _ready() -> void:
	velocity = position.direction_to(destination)
	$Sprite2D.rotation = velocity.angle() + PI/2

func _process(delta: float) -> void:
	if position.distance_to(destination) <= 30:
		queue_free()
		
	position += velocity * speed * delta
