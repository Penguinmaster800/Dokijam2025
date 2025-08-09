extends LevelParent

func _ready():
	level_startup()
	Status.enemies_remaining = 2
	Status.time_remaining = 80
	Status.doki_max_ammo = 6
	Status.doki_max_health = 10
	Status.doki_health = Status.doki_max_health
	Status.doki_ammo = Status.doki_max_ammo
	Status.level = 1
	
	
	
	
	spawn_enemy_gunman(1)
	spawn_enemy_brute(2)
