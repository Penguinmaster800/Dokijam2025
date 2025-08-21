extends CanvasLayer

var going_ghost_tracker_scene : PackedScene = preload("res://scenes/user interface/going_ghost_tracker.tscn")
var red_eye_tracker_scene : PackedScene = preload("res://scenes/user interface/red_eye_tracker.tscn")
var aim_bot_tracker_scene : PackedScene = preload("res://scenes/user interface/aim_bot_tracker.tscn")

@onready var ability_1_marker: Marker2D = $"AbilityTrackers/Ability 1"
@onready var ability_2_marker: Marker2D = $"AbilityTrackers/Ability 2"
@onready var ability_3_marker: Marker2D = $"AbilityTrackers/Ability 3"
var ability_marker_offset: int = 100
var is_ability_1: bool = false
var is_ability_2: bool = false
var is_ability_3: bool = false

func _ready():
	Status.doki_health_change.connect(_doki_health_change)
	Status.connect("doki_ammo_change", _doki_ammo_change)
	Status.enemies_remaining_change.connect(_enemies_remaining_change)
	_get_max_hp()
	_get_max_ammo()
	_check_all_abilities()

func _doki_health_change():
	$HpBar.value = Status.doki_health

func _doki_ammo_change():
	$AmmoTracker.value = Status.doki_ammo

func _enemies_remaining_change():
	$DragoonCounter/Label.text = str(Status.enemies_remaining)

func _check_all_abilities():
	_check_ability_existance(Abilities.ability1, Abilities.ability2, Abilities.ability3)
	_check_ability(ability_1_marker, Abilities.ability1, _get_ability_keybind("Ability 1"))
	_check_ability(ability_2_marker, Abilities.ability2, _get_ability_keybind("Ability 2"))
	_check_ability(ability_3_marker, Abilities.ability3, _get_ability_keybind("Ability 3"))

func _check_ability_existance(ability1, ability2, ability3) -> void:

	if ability1:
		is_ability_1 = true
		
	if ability2:
		is_ability_2 = true
		ability_1_marker.position.x -= ability_marker_offset
		
	if ability3:
		is_ability_3 = true
		ability_1_marker.position.x -= ability_marker_offset
		ability_2_marker.position.x -= ability_marker_offset

func _check_ability(ability_marker, ability, ability_keybind):
	if ability == "Aim Bot":
		_get_aim_bot(ability_marker, ability_keybind)
	if ability == "Going Ghost":
		_get_going_ghost(ability_marker, ability_keybind)
	if ability == "Red Eye":
		_get_red_eye(ability_marker, ability_keybind)
		
func _get_ability_keybind(action_name: String) -> String:
	var events := InputMap.action_get_events(action_name)
	for event: InputEvent in events:
		if event is InputEventKey:
			return event.as_text_physical_keycode()
	return ""

func _get_going_ghost(ability_marker, ability_keybind):
	var going_ghost_tracker = going_ghost_tracker_scene.instantiate()
	going_ghost_tracker.position = ability_marker.position
	going_ghost_tracker.keybind = ability_keybind
	print("goingGhostTrackerSpawned")
	get_node("AbilityTrackers").add_child(going_ghost_tracker)

func _get_red_eye(ability_marker, ability_keybind):
	var red_eye_tracker = red_eye_tracker_scene.instantiate()
	red_eye_tracker.position = ability_marker.position
	red_eye_tracker.keybind = ability_keybind
	print("red eye tracker spawned")
	get_node("AbilityTrackers").add_child(red_eye_tracker)

func _get_aim_bot(ability_marker, ability_keybind):
	var aim_bot_tracker = aim_bot_tracker_scene.instantiate()
	aim_bot_tracker.position = ability_marker.position
	aim_bot_tracker.keybind = ability_keybind
	print("aim bot tracker spawned")
	get_node("AbilityTrackers").add_child(aim_bot_tracker)

func _get_max_ammo():
	if Status.doki_max_ammo == 6:
		$AmmoTracker.set_under_texture(load("res://assets/ui/6 Bullet Empty.png"))
		$AmmoTracker.set_progress_texture(load("res://assets/ui/6 Bullet Full.png"))
		$TextureRect.set_texture(load("res://assets/ui/6 Bullet Bandalier.png"))
		$AmmoTracker.position = Vector2(1211, 525)
		$AmmoTracker.max_value = 6
	elif Status.doki_max_ammo == 8:
		$AmmoTracker.set_under_texture(load("res://assets/ui/8 Bullet Empty.png"))
		$AmmoTracker.set_progress_texture(load("res://assets/ui/8 Bullet Full.png"))
		$TextureRect.set_texture(load("res://assets/ui/8 Bullet Bandalier.png"))
		$AmmoTracker.position = Vector2(1211, 497)
		$AmmoTracker.max_value = 8
	elif Status.doki_max_ammo == 10:
		$AmmoTracker.set_under_texture(load("res://assets/ui/10 Bullet Empty.png"))
		$AmmoTracker.set_progress_texture(load("res://assets/ui/10 Bullet Full.png"))
		$TextureRect.set_texture(load("res://assets/ui/10 Bullet Bandalier.png"))
		$AmmoTracker.position = Vector2(1211, 471)
		$AmmoTracker.max_value = 10
	elif Status.doki_max_ammo == 12:
		$AmmoTracker.set_under_texture(load("res://assets/ui/12 Bullet Empty.png"))
		$AmmoTracker.set_progress_texture(load("res://assets/ui/12 Bullet Full.png"))
		$TextureRect.set_texture(load("res://assets/ui/12 Bullet Bandalier.png"))
		$AmmoTracker.position = Vector2(1211, 448)
		$AmmoTracker.max_value = 12

func _get_max_hp():
	if Status.doki_max_health == 10:
		$HpBar.set_under_texture(load("res://assets/ui/HP10Dead.png"))
		$HpBar.set_progress_texture(load("res://assets/ui/HP10Alive.png"))
		$HpBar.position = Vector2(300, -1)
	elif Status.doki_max_health == 14:
		$HpBar.set_under_texture(load("res://assets/ui/HP14Dead.png"))
		$HpBar.set_progress_texture(load("res://assets/ui/HP14Alive.png"))
		$HpBar.position = Vector2(410, -1)
	elif Status.doki_max_health == 18:
		$HpBar.set_under_texture(load("res://assets/ui/HP18Dead.png"))
		$HpBar.set_progress_texture(load("res://assets/ui/HP18Alive.png"))
		$HpBar.position = Vector2(640, -1)
