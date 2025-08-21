extends Node2D

var health_up_scene = preload("res://scenes/objects/ui/health_up.tscn")
var ammo_up_scene = preload("res://scenes/objects/ui/ammo_up.tscn")
var going_ghost_scene = preload("res://scenes/objects/ui/going_ghost_get.tscn")
var aim_bot_scene = preload("res://scenes/objects/ui/aim_bot_get.tscn")
var red_eye_scene = preload("res://scenes/objects/ui/red_eye_get.tscn")

@onready var upgrade_1_marker = $UpgradeLocations/upgrade_1
@onready var upgrade_2_marker = $UpgradeLocations/upgrade_2
@onready var upgrade_3_marker = $UpgradeLocations/upgrade_3

var upgrade_options:= [health_up_scene, ammo_up_scene, going_ghost_scene, red_eye_scene, aim_bot_scene]
var random_options = [health_up_scene, ammo_up_scene, going_ghost_scene, red_eye_scene, aim_bot_scene]
func _ready():
	print(random_options)
	_update_options()
	_randomize_options()
	_spawn_upgrade_1(random_options[0])
	if random_options.size() > 1:
		_spawn_upgrade_2(random_options[1])
	if random_options.size() > 2:
		_spawn_upgrade_3(random_options[2])

func _update_options():
	if Abilities.aim_bot_learned == true:
		upgrade_options.erase(aim_bot_scene)
	if Abilities.red_eye_learned == true:
		upgrade_options.erase(red_eye_scene)
	if Abilities.going_ghost_learned == true:
		upgrade_options.erase(going_ghost_scene)

func _randomize_options():
	random_options = upgrade_options.duplicate()
	random_options.shuffle()


func _spawn_upgrade_1(selected_position):
	var chosen_upgrade_1 = selected_position.instantiate()
	chosen_upgrade_1.global_position = upgrade_1_marker.global_position
	add_child(chosen_upgrade_1)

func _spawn_upgrade_2(selected_position):
	var chosen_upgrade_2 = selected_position.instantiate()
	chosen_upgrade_2.global_position = upgrade_2_marker.global_position
	add_child(chosen_upgrade_2)

func _spawn_upgrade_3(selected_position):
	var chosen_upgrade_3 = selected_position.instantiate()
	chosen_upgrade_3.global_position = upgrade_3_marker.global_position
	add_child(chosen_upgrade_3)


func vanish():
	$AnimationPlayer.play("Vanish")
	await $AnimationPlayer.animation_finished
	$".".hide()
	
