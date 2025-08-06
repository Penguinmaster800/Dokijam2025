extends Node

signal aim_bot_activate
signal red_eye_activate
signal going_ghost_activate

var ability1 = null
var ability2 = null
var ability3 = null

var ability1_ready : bool = false
var ability2_ready : bool = false
var ability3_ready : bool = false


var going_ghost_active: bool = false
var red_eye_active: bool = false
var aim_bot_active: bool = false

func aim_bot():
	aim_bot_active = true
	aim_bot_activate.emit()

func red_eye():
	red_eye_active = true
	red_eye_activate.emit()

func going_ghost():
	going_ghost_active = true
	going_ghost_activate.emit()

func obtain_ability(new_ability):
	if ability1 == null:
		ability1 = new_ability
	elif ability2 == null:
		ability2 = new_ability
	elif ability3 == null:
		ability3 = new_ability
