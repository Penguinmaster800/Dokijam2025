extends LevelParent

func _ready():
	level_startup()
	Status.enemies_remaining = 8
	Status.time_remaining = 150
	Status.doki_health = Status.doki_max_health
	Status.doki_ammo = Status.doki_max_ammo
	Status.level = 2
	Status.doki_shot = 0
	AudioManager.level_one_music.stop()
	AudioManager.level_two_music.play()

	setup_enemy_waves(2)


func spawn_wave(wave_number: int):
	match wave_number:
		1:
			spawn_wave_1()
		2:
			spawn_wave_2()

func spawn_wave_1():
	wave_enemy_count = 4
	spawn_enemy_sniper(EnumRowNo.RowNo.ROW4)
	spawn_enemy_brute_random_row()
	spawn_enemy_gunman_random_row()
	spawn_enemy_gunman_random_row()
	spawn_env_object_drone(EnumRowNo.RowNo.ROW1)

func spawn_wave_2():
	wave_enemy_count = 4
	spawn_enemy_sniper(EnumRowNo.RowNo.ROW4)
	spawn_enemy_brute_random_row()
	spawn_enemy_gunman_random_row()
	spawn_enemy_gunman_random_row()
	spawn_env_object_drone(EnumRowNo.RowNo.ROW1)
