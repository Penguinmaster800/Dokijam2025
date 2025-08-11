extends LevelParent

func _ready():
	level_startup()
	Status.enemies_remaining = 2
	Status.time_remaining = 80
	Status.doki_health = Status.doki_max_health
	Status.doki_ammo = Status.doki_max_ammo
	Status.level = 3
	Status.doki_shot = 0
	AudioManager.level_one_music.play()
