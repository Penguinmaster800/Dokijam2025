extends Control

func _ready():
	$AnimationPlayer.play("RESET")
	hide()

func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")
	hide()

func pause():
	get_tree().paused = true
	$AnimationPlayer.play("blur")
	show()

func testEsc():
	if Input.is_action_just_pressed("esc") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("esc") and get_tree().paused:
		resume()



func _on_resume_pressed() -> void:
	resume()


func _on_quit_to_menu_pressed() -> void:
	resume()
	TransitionLayer.change_scene("res://scenes/menus/main_menu.tscn")

func _process(_delta):
	testEsc()
