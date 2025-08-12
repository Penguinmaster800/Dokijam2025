extends Node

signal aim_bot_activate
signal red_eye_activate
signal going_ghost_activate
signal aim_bot_time_remaining_change
signal going_ghost_time_remaining_change
signal red_eye_time_remaining_change
signal red_eye_cover_change

var aim_bot_learned : bool = false
var going_ghost_learned : bool = false
var red_eye_learned : bool = false

var ability1 = null
var ability2 = null
var ability3 = null

var aim_bot_ready : bool = false
var aim_bot_time_remaining: float = 40:
	set(value):
		aim_bot_time_remaining = value
		aim_bot_time_remaining_change.emit()
var going_ghost_ready : bool = false
var going_ghost_time_remaining: float = 25:
	set(value):
		going_ghost_time_remaining = value
		going_ghost_time_remaining_change.emit()
var red_eye_ready : bool = false
var red_eye_time_remaining: float = 45:
	set(value):
		red_eye_time_remaining = value
		red_eye_time_remaining_change.emit()

var red_eye_cover : bool = false:
	set(value):
		red_eye_cover = value
		red_eye_cover_change.emit()

var going_ghost_active: bool = false
var red_eye_active: bool = false
var aim_bot_active: bool = false

func aim_bot():
	if Abilities.aim_bot_ready == true && Status.doki_ammo >= 6:
		print("aim_bot_activated")
		Status.doki_ammo -=6
		aim_bot_activate.emit()
		

func red_eye():
	if Abilities.red_eye_ready == true:
		print("red eye_activated")
		red_eye_active = true
		red_eye_activate.emit()

func going_ghost():
	if Abilities.going_ghost_ready == true:
		print("going ghost_activated")
		going_ghost_active = true
		going_ghost_activate.emit()

func obtain_ability(new_ability):
	print(ability1, ability2, ability3)
	if ability3 == null and ability2 != null:
		ability3 = new_ability
	if ability2 == null and ability1 != null:
		ability2 = new_ability
	if ability1 == null:
		ability1 = new_ability
		print(ability1)
	
	
	
