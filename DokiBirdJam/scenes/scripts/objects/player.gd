extends CharacterBody2D


var target = exposed_location_x
const cover_location_x: int = 100
const exposed_location_x: int = 300
const doki_location_y: int = 638

#speed at which doki will enter and exit cover. this is here to make tuning for feel easier
var speed : int = 40000

#functions called when instantiated, will fill with checks connecting to signals and resets states

func _ready():
	target = Vector2(exposed_location_x,doki_location_y)
	
	pass

func _process(delta):
	velocity = position.direction_to(target) * speed * delta
	if position.distance_to(target) > 10:
		move_and_slide()
	else:
		position = target
	if position.x >=290:
		Status.in_cover = false
	else:
		Status.in_cover = true


func _input(event):
	if event.is_action_pressed("enter_cover"):
		target = cover_location_x
		move_to_x_pos(target)
	elif event.is_action_released("enter_cover"):
		target = exposed_location_x
		move_to_x_pos(target)

func move_to_x_pos(x_pos: float):
	target = Vector2(x_pos, position.y)


func red_eye():
	$RedEyeTimer
func going_ghost():
	$GoingGhostTimer
