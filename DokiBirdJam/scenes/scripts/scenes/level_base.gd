extends Node2D

var reloading: bool = false

func _ready():
	Status.doki_health_change.connect(_doki_health_change)
	Status.doki_ammo_change.connect(_doki_ammo_change)



func reload():
	if reloading == true:
		pass
	if Status.doki_ammo == Status.doki_max_ammo:
		pass

func _input(event):
	if event.is_action_pressed("primary action"):
		if Status.doki_ammo <= 0:
			#play sound of no ammo
			reload()






func _doki_health_change():
	$"Hp-Bar".value = Status.doki_health

func _doki_ammo_change():
	$"Ammo Tracker".value = Status.doki_ammo
