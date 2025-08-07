extends CanvasLayer


func _ready():
	Status.doki_health_change.connect(_doki_health_change)
	Status.doki_ammo_change.connect(_doki_ammo_change)
	Status.enemies_remaining_change.connect(_enemies_remaining_change)

func _doki_health_change():
	$"Hp-Bar".value = Status.doki_health

func _doki_ammo_change():
	$"Ammo Tracker".value = Status.doki_ammo

func _enemies_remaining_change():
	$Control/Label.text = str(Status.enemies_remaining)
