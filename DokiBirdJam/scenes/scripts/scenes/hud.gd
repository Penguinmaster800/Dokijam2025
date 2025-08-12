extends CanvasLayer

var going_ghost_tracker_scene : PackedScene = preload("res://scenes/user interface/going_ghost_tracker.tscn")
var red_eye_tracker_scene : PackedScene = preload("res://scenes/user interface/red_eye_tracker.tscn")
var aim_bot_tracker_scene : PackedScene = preload("res://scenes/user interface/aim_bot_tracker.tscn")

func _ready():
	Status.doki_health_change.connect(_doki_health_change)
	#Status.connect("doki_ammo_change", _doki_ammo_change)
	Status.enemies_remaining_change.connect(_enemies_remaining_change)
	_check_all_abilities()

func _doki_health_change():
	$HpBar.value = Status.doki_health

#func _doki_ammo_change():
#	$AmmoTracker.value = Status.doki_ammo

func _enemies_remaining_change():
	$DragoonCounter/Label.text = str(Status.enemies_remaining)

func _check_all_abilities():
	print(Abilities.ability1, Abilities.ability2, Abilities.ability3)
	_check_ability($"AbilityTrackers/Ability 1", Abilities.ability1)
	_check_ability($"AbilityTrackers/Ability 2", Abilities.ability2)
	_check_ability($"AbilityTrackers/Ability 3", Abilities.ability3)

func _check_ability(ability_marker, ability):
	if ability == "Aim Bot":
		_get_aim_bot(ability_marker)
	if ability == "Going Ghost":
		_get_going_ghost(ability_marker)
	if ability == "Red Eye":
		_get_red_eye(ability_marker)


func _get_going_ghost(ability_marker):
	var going_ghost_tracker = going_ghost_tracker_scene.instantiate()
	going_ghost_tracker.position =ability_marker.position
	print("goingGhostTrackerSpawned")
	get_node("AbilityTrackers").add_child(going_ghost_tracker)

func _get_red_eye(ability_marker):
	var red_eye_tracker = red_eye_tracker_scene.instantiate()
	red_eye_tracker.position = ability_marker.position
	print("red eye tracker spawned")
	get_node("AbilityTrackers").add_child(red_eye_tracker)

func _get_aim_bot(ability_marker):
	var aim_bot_tracker = aim_bot_tracker_scene.instantiate()
	aim_bot_tracker.position = ability_marker.position
	print("aim bot tracker spawned")
	get_node("AbilityTrackers").add_child(aim_bot_tracker)
