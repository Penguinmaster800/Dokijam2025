extends Node2D
class_name LevelParent

var reloading: bool = false

func _ready():
	Status.doki_health_change.connect(_doki_health_change)
	Status.doki_ammo_change.connect(_doki_ammo_change)
	Status.doki_ammo = Status.doki_max_ammo



func reload():
	if reloading == true:
		pass
	if Status.doki_ammo == Status.doki_max_ammo:
		pass
	if Status.doki_ammo < Status.doki_max_ammo:
		$"Reload Timer".start()
		reloading = true
		print("reloading")

func _on_reload_timer_timeout() -> void:
	Status.doki_ammo = Status.doki_max_ammo
	reloading = false
	print("reloading complete")
	$"Reload Timer".stop()


func _input(event):
	if event.is_action_pressed("primary action"):
		if Status.doki_ammo <= 0 and not reloading:
			#play sound of no ammo
			reload()
		elif  Status.doki_ammo >=1 and not reloading and Status.in_cover == false:
			#play fire sound
			Status.doki_ammo -=1
			#send damage signal
		
	if event.is_action_pressed("reload"):
		reload()
	
	if event.is_action_pressed("Ability 1"):
		Abilities.ability1
	if event.is_action_pressed("Ability 2"):
		Abilities.ability2
	if event.is_action_pressed("Ability 3"):
		Abilities.ability3





func _doki_health_change():
	$"Hp-Bar".value = Status.doki_health

func _doki_ammo_change():
	$"Ammo Tracker".value = Status.doki_ammo
