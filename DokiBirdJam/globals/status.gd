extends Node

signal doki_health_change
signal doki_max_health_change
signal doki_ammo_change
signal doki_max_ammo_change
signal enemies_remaining_change
signal doki_can_fire_change
signal time_remaining_change
signal level_change
signal doki_reloading_change
signal doki_shot_change


var level: int = 1:
	set(value):
		level = value
		level_change.emit()

var doki_max_health: int = 1:
	set(value):
		doki_max_health = value
		doki_max_health_change.emit()

var doki_health: int = doki_max_health:
	set(value):
		doki_health = value
		doki_health_change.emit()

var doki_max_ammo: int = 1:
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

var time_remaining: float = 80:
	set(value):
		time_remaining = value
		time_remaining_change.emit()

var in_cover: bool = false
var doki_reloading: bool = false:
	set(value):
		doki_reloading = value
		doki_reloading_change.emit()
var doki_can_fire: bool = true:
	set(value):
		doki_can_fire = value
		doki_can_fire_change.emit()
var doki_shot: int =0:
	set(value):
		doki_shot = value
		doki_shot_change.emit()
var doki_shot_cooldown: bool = false
