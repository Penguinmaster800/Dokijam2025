extends CanvasLayer


func _ready():
	Status.doki_health_change.connect(_doki_health_change)
	Status.connect("doki_ammo_change", _doki_ammo_change)
	Status.enemies_remaining_change.connect(_enemies_remaining_change)

func _doki_health_change():
	$HpBar.value = Status.doki_health

func _doki_ammo_change():
	$AmmoTracker.value = Status.doki_ammo

func _enemies_remaining_change():
	$DragoonCounter/Label.text = str(Status.enemies_remaining)
