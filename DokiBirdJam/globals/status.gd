extends Node

signal doki_health_change
signal doki_max_health_change
signal doki_ammo_change
signal doki_max_ammo_change
signal enemies_remaining_change

var doki_max_health: int = 10:
	set(value):
		doki_max_health = value
		doki_max_health_change.emit()

var doki_health: int = doki_max_health:
	set(value):
		doki_health = value
		doki_health_change.emit()

var doki_max_ammo: int = 6:
	set(value):
		doki_max_ammo = value
		doki_max_ammo_change.emit()

var doki_ammo: int = doki_max_ammo:
	set(value):
		doki_ammo = value
		doki_ammo_change.emit()

var enemies_remaining: int = 12:
	set(value):
		enemies_remaining = value
		enemies_remaining_change.emit()
