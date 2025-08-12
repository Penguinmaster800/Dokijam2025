extends Area2D

func _ready():
	Abilities.red_eye_cover_change.connect(_red_eye)


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if not event.is_action_pressed("primary action"):
		return

func _red_eye():
	if Abilities.red_eye_active == true:
		$CollisionPolygon2D.hide()
		$Sprite2D.modulate.a = 0.6
	if Abilities.red_eye_active == false:
		$CollisionPolygon2D.show()
		$Sprite2D.modulate.a = 1
