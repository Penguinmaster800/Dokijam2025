extends LevelParent

func _ready():
	level_startup()
	Status.enemies_remaining = 13
	Status.time_remaining = 80
	Status.doki_health = Status.doki_max_health
	Status.doki_ammo = Status.doki_max_ammo
	Status.level = 1
	Status.doki_shot = 0

	AudioManager.intermission_music.stop()
	AudioManager.level_one_music.play()
  AudioManager.game_over_music.stop()
	Status.score = 0
	Status.time_remaining_change.connect(time_spawn)
	setup_enemy_waves(2)

	
func spawn_wave(wave_number: int):
	match wave_number:
		1:
			spawn_wave_1()
		2:
			spawn_wave_2()
		3:
			spawn_wave_3()

func spawn_wave_1():
	wave_enemy_count = 4
	spawn_enemy_gunman_random_row()
	spawn_enemy_gunman_random_row()
	spawn_enemy_gunman_random_row()
	spawn_enemy_gunman_random_row()
	spawn_env_object_drone(EnumRowNo.RowNo.ROW1, electric_drone)
	spawn_env_object_drone(EnumRowNo.RowNo.ROW3, explosion_drone)

func spawn_wave_2():
	wave_enemy_count = 5
	spawn_enemy_sniper(EnumRowNo.RowNo.ROW3)
	spawn_enemy_gunman_random_row()
	spawn_enemy_gunman_random_row()
	spawn_enemy_gunman_random_row()
	spawn_enemy_gunman_random_row()
	spawn_env_object_drone(EnumRowNo.RowNo.ROW1)

func spawn_wave_3():
	wave_enemy_count = 4
	spawn_enemy_stationary(EnumRowNo.RowNo.ROW4)
	spawn_enemy_gunman_random_row()
	spawn_enemy_gunman_random_row()
	spawn_enemy_gunman_random_row()
	spawn_env_object_drone(EnumRowNo.RowNo.ROW1)

func time_spawn():
	if Status.time_remaining == 70:
		spawn_env_object_drone(EnumRowNo.RowNo.ROW2)
