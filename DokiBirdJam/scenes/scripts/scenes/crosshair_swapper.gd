extends Node2D

var no_ammo = preload("res://assets/ui/Crosshairs/No Ammo.png")
var one_ammo = preload("res://assets/ui/Crosshairs/1.png")
var two_ammo = preload("res://assets/ui/Crosshairs/2.png")
var three_ammo = preload("res://assets/ui/Crosshairs/3.png")
var four_ammo = preload("res://assets/ui/Crosshairs/4.png")
var five_ammo = preload("res://assets/ui/Crosshairs/5.png")
var six_ammo = preload("res://assets/ui/Crosshairs/6.png")
var seven_ammo = preload("res://assets/ui/Crosshairs/7.png")
var eight_ammo = preload("res://assets/ui/Crosshairs/8.png")
var nine_ammo = preload("res://assets/ui/Crosshairs/9.png")
var ten_ammo = preload("res://assets/ui/Crosshairs/10.png")
var eleven_ammo = preload("res://assets/ui/Crosshairs/11.png")
var twelve_ammo = preload("res://assets/ui/Crosshairs/12.png")

func _ready():
	Status.doki_ammo_change.connect(_update_curser)


func _update_curser():
	if Status.doki_ammo == 0:
		Input.set_custom_mouse_cursor(no_ammo, Input.CURSOR_ARROW, Vector2(42, 49))
	if Status.doki_ammo == 1:
		Input.set_custom_mouse_cursor(one_ammo, Input.CURSOR_ARROW, Vector2(42, 49))
	if Status.doki_ammo == 2:
		Input.set_custom_mouse_cursor(two_ammo, Input.CURSOR_ARROW, Vector2(42, 49))
	if Status.doki_ammo == 3:
		Input.set_custom_mouse_cursor(three_ammo, Input.CURSOR_ARROW, Vector2(42, 49))
	if Status.doki_ammo == 4:
		Input.set_custom_mouse_cursor(four_ammo, Input.CURSOR_ARROW, Vector2(42, 49))
	if Status.doki_ammo == 5:
		Input.set_custom_mouse_cursor(five_ammo, Input.CURSOR_ARROW, Vector2(42, 49))
	if Status.doki_ammo == 6:
		Input.set_custom_mouse_cursor(six_ammo, Input.CURSOR_ARROW, Vector2(42, 49))
	if Status.doki_ammo == 7:
		Input.set_custom_mouse_cursor(seven_ammo, Input.CURSOR_ARROW, Vector2(42, 49))
	if Status.doki_ammo == 8:
		Input.set_custom_mouse_cursor(eight_ammo, Input.CURSOR_ARROW, Vector2(42, 49))
	if Status.doki_ammo == 9:
		Input.set_custom_mouse_cursor(nine_ammo, Input.CURSOR_ARROW, Vector2(42, 49))
	if Status.doki_ammo == 10:
		Input.set_custom_mouse_cursor(ten_ammo, Input.CURSOR_ARROW, Vector2(42, 49))
	if Status.doki_ammo == 11:
		Input.set_custom_mouse_cursor(eleven_ammo, Input.CURSOR_ARROW, Vector2(42, 49))
	if Status.doki_ammo == 12:
		Input.set_custom_mouse_cursor(twelve_ammo, Input.CURSOR_ARROW, Vector2(42, 49))
