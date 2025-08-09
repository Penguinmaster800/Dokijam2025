extends Node2D

func _ready():
	Abilities.ability1 = null
	Abilities.ability2 = null
	Abilities.ability3 = null

func _on_button_pressed() -> void:
	TransitionLayer.change_scene("res://scenes/menus/main_menu.tscn")
