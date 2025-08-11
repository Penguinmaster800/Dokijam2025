extends CharacterBody2D


var target = exposed_location_x
const cover_location_x: int = 150
const exposed_location_x: int = 300
const doki_location_y: int = 638

#speed at which doki will enter and exit cover. this is here to make tuning for feel easier
var speed : int = 40000

#functions called when instantiated, will fill with checks connecting to signals and resets states

func _ready():
	target = Vector2(exposed_location_x,doki_location_y)
	Status.doki_reloading_change.connect(_reload)
	Status.doki_shot_change.connect(_fire)
	
func _on_animated_sprite_2d_animation_finished() -> void:
	if Status.in_cover == true:
		$AnimatedSprite2D.play("InCover")
func _process(delta):
	velocity = position.direction_to(target) * speed * delta
	if position.distance_to(target) > 15:
		move_and_slide()
	else:
		position = target
	if position.x <= cover_location_x+10:
		Status.in_cover = true
	else:
		Status.in_cover = false
	if position.x >= exposed_location_x - 10:
		Status.doki_exposed = true
	else:
		Status.doki_exposed = false


func _input(event):
	if event.is_action_pressed("enter_cover") && Status.doki_reloading == false:
		target = cover_location_x
		move_to_x_pos(target)
		$AnimatedSprite2D.play("EnterCover")
	if event.is_action_released("enter_cover") && Status.doki_reloading == false:
		target = exposed_location_x
		move_to_x_pos(target)
		$AnimatedSprite2D.play("ExitCover")
	if event.is_action_pressed("enter_cover"):
		Status.cover_held = true
	if event.is_action_released("enter_cover"):
		Status.cover_held = false

func move_to_x_pos(x_pos: float):
	target = Vector2(x_pos, position.y)

func _fire():
	if Status.doki_shot != 0:
		$AnimatedSprite2D.play("Fire")

func _reload():
	if Status.doki_reloading == true && Status.in_cover == true:
		target = Vector2(cover_location_x, doki_location_y)
	if Status.doki_reloading == true && Status.in_cover == false:
		target = Vector2(cover_location_x, doki_location_y)
		$AnimatedSprite2D.play("EnterCover")
	if Status.doki_reloading == false && Status.in_cover == true && Status.cover_held == false:
		target = Vector2(exposed_location_x, doki_location_y)
		$AnimatedSprite2D.play("ExitCover")
	if Status.doki_reloading == false && Status.in_cover == false && Status.cover_held == false:
		target = Vector2(exposed_location_x, doki_location_y)

func red_eye():
	$RedEyeTimer
func going_ghost():
	$GoingGhostTimer
