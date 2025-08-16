extends LevelParent

var total_enemies = 0

func _ready():
	level_startup()
	Status.enemies_remaining = 33
	Status.time_remaining = 210
	Status.doki_health = Status.doki_max_health
	Status.doki_ammo = Status.doki_max_ammo
	Status.level = 3
	Status.doki_shot = 0
	AudioManager.game_over_music.stop()
	AudioManager.level_three_music.play()
	AudioManager.level_two_music.stop()
	setup_enemy_waves(8)


func spawn_wave(wave_number: int):
	match wave_number:
		1:
			spawn_wave_1()
		2:
			spawn_wave_2()
		3:
			spawn_wave_3()
		4:
			spawn_wave_4()
		5:
			spawn_wave_5()
		6:
			spawn_wave_6()
		7:
			spawn_wave_7()
		8:
			spawn_wave_8()

func spawn_wave_1():
	wave_enemy_count = 5
	spawn_enemy_heavy(EnumRowNo.RowNo.ROW3)
	spawn_enemy_gunman_random_row()
	spawn_enemy_gunman_random_row()
	spawn_enemy_gunman_random_row()
	spawn_enemy_gunman_random_row()
	spawn_env_object_drone(EnumRowNo.RowNo.ROW1)

func spawn_wave_2():
	wave_enemy_count = 4
	spawn_enemy_sniper(EnumRowNo.RowNo.ROW4)
	spawn_enemy_gunman_random_row()
	spawn_enemy_gunman_random_row()
	spawn_enemy_gunman_random_row()
	spawn_env_object_drone(EnumRowNo.RowNo.ROW1)

func spawn_wave_3():
	wave_enemy_count = 4
	spawn_enemy_sniper(EnumRowNo.RowNo.ROW4)
	spawn_enemy_brute(EnumRowNo.RowNo.ROW3)
	spawn_enemy_gunman_random_row()
	spawn_enemy_gunman_random_row()
	spawn_env_object_drone(EnumRowNo.RowNo.ROW1)

func spawn_wave_4():
	wave_enemy_count = 4
	spawn_enemy_stationary(EnumRowNo.RowNo.ROW4)
	spawn_enemy_gunman_random_row()
	spawn_enemy_gunman_random_row()
	spawn_enemy_gunman_random_row()
	spawn_env_object_drone(EnumRowNo.RowNo.ROW1)

func spawn_wave_5():
	wave_enemy_count = 4
	spawn_enemy_stationary(EnumRowNo.RowNo.ROW4)
	spawn_enemy_gunman_random_row()
	spawn_enemy_gunman_random_row()
	spawn_enemy_gunman_random_row()
	spawn_env_object_drone(EnumRowNo.RowNo.ROW1)

func spawn_wave_6():
	wave_enemy_count = 4
	spawn_enemy_stationary(EnumRowNo.RowNo.ROW4)
	spawn_enemy_gunman_random_row()
	spawn_enemy_gunman_random_row()
	spawn_enemy_gunman_random_row()
	spawn_env_object_drone(EnumRowNo.RowNo.ROW1)

func spawn_wave_7():
	wave_enemy_count = 4
	spawn_enemy_stationary(EnumRowNo.RowNo.ROW4)
	spawn_enemy_gunman_random_row()
	spawn_enemy_gunman_random_row()
	spawn_enemy_gunman_random_row()
	spawn_env_object_drone(EnumRowNo.RowNo.ROW1)

func spawn_wave_8():
	wave_enemy_count = 4
	spawn_enemy_stationary(EnumRowNo.RowNo.ROW4)
	spawn_enemy_gunman_random_row()
	spawn_enemy_gunman_random_row()
	spawn_enemy_gunman_random_row()
	spawn_env_object_drone(EnumRowNo.RowNo.ROW1)
