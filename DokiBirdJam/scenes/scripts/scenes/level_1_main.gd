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
	AudioManager.level_one_music.play()
	
	
	
	spawn_enemy_brute(EnumRowNo.RowNo.ROW1)
	spawn_enemy_gunman(EnumRowNo.RowNo.ROW2)
	spawn_enemy_sniper(EnumRowNo.RowNo.ROW3)
	spawn_env_object_drone(EnumRowNo.RowNo.ROW1)
