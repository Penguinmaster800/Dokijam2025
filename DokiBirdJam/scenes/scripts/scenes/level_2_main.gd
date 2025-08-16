extends LevelParent

var env_object_battery_scene: PackedScene = preload("res://scenes/objects/Environment/env_object_warehouse_battery.tscn")
var env_object_explosives_scene: PackedScene = preload("res://scenes/objects/Environment/env_object_warehouse_explosives.tscn")

func _ready():
	level_startup()
	Status.enemies_remaining = 24
	Status.time_remaining = 151
	Status.doki_health = Status.doki_max_health
	Status.doki_ammo = Status.doki_max_ammo
	Status.level = 2
	Status.doki_shot = 0

	AudioManager.intermission_music.stop()

	AudioManager.level_two_music.play()
	setup_enemy_waves(6)
	spawn_object_conveyor_random()
	$Timers/ConveyorBeltSpawnTimer.start()
	spawn_object_conveyor_random_row2()
	$Timers/ConveyorBeltRow2SpawnTimer.start()

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

func spawn_wave_1():
	wave_enemy_count = 4
	spawn_enemy_sniper(EnumRowNo.RowNo.ROW4)
	spawn_enemy_brute_random_row()
	spawn_enemy_gunman_random_row()
	spawn_enemy_gunman_random_row()
	spawn_env_object_drone(EnumRowNo.RowNo.ROW1)

func spawn_wave_2():
	wave_enemy_count = 4
	spawn_enemy_stationary(EnumRowNo.RowNo.ROW2)
	spawn_enemy_brute_random_row()
	spawn_enemy_gunman_random_row()
	spawn_enemy_gunman_random_row()
	spawn_env_object_drone(EnumRowNo.RowNo.ROW1)

func spawn_wave_3():
	wave_enemy_count = 4
	spawn_enemy_sniper(EnumRowNo.RowNo.ROW4)
	spawn_enemy_brute_random_row()
	spawn_enemy_heavy(EnumRowNo.RowNo.ROW2)
	spawn_enemy_gunman_random_row()
	spawn_env_object_drone(EnumRowNo.RowNo.ROW1)

func spawn_wave_4():
	wave_enemy_count = 4
	spawn_enemy_sniper(EnumRowNo.RowNo.ROW4)
	spawn_enemy_brute_random_row()
	spawn_enemy_gunman_random_row()
	spawn_enemy_gunman_random_row()
	spawn_env_object_drone(EnumRowNo.RowNo.ROW1)

func spawn_wave_5():
	wave_enemy_count = 4
	spawn_enemy_sniper(EnumRowNo.RowNo.ROW4)
	spawn_enemy_brute_random_row()
	spawn_enemy_gunman_random_row()
	spawn_enemy_heavy(EnumRowNo.RowNo.ROW1)
	spawn_env_object_drone(EnumRowNo.RowNo.ROW1)

func spawn_wave_6():
	wave_enemy_count = 4
	spawn_enemy_sniper(EnumRowNo.RowNo.ROW4)
	spawn_enemy_brute_random_row()
	spawn_enemy_gunman_random_row()
	spawn_enemy_gunman_random_row()
	spawn_env_object_drone(EnumRowNo.RowNo.ROW1)

func spawn_object_conveyor_random():
	var rand_val = randi_range(1, 2)
	match rand_val:
		1:
			spawn_object_conveyor_battery()
		2:
			spawn_object_conveyor_explosives()

func spawn_object_conveyor_battery():
	spawn_object_conveyor(env_object_battery_scene)

func spawn_object_conveyor_explosives():
	spawn_object_conveyor(env_object_explosives_scene)

func spawn_object_conveyor(scene: PackedScene):
	var spawn_pos = $EnemyLayer/Row1/Covers/EnvObjectsWarehouseConveyorR1/Points/Marker2DSpawnPoint.global_position
	var dest_pos = $EnemyLayer/Row1/Covers/EnvObjectsWarehouseConveyorR1/Points/Marker2DDestinationPoint.global_position
	var env_object = scene.instantiate()
	env_object.position = spawn_pos
	env_object.dest_pos = dest_pos
	env_object.row_no = EnumRowNo.RowNo.ROW1
	$EnemyLayer/Row1/Covers/EnvObjectsWarehouseConveyorR1.add_child(env_object)

func spawn_object_conveyor_random_row2():
	var rand_val = randi_range(1, 2)
	match rand_val:
		1:
			spawn_object_conveyor_battery_row2()
		2:
			spawn_object_conveyor_explosives_row2()

func spawn_object_conveyor_battery_row2():
	spawn_object_conveyor_row2(env_object_battery_scene)

func spawn_object_conveyor_explosives_row2():
	spawn_object_conveyor_row2(env_object_explosives_scene)

func spawn_object_conveyor_row2(scene: PackedScene):
	var spawn_pos = $EnemyLayer/Row2/Covers/EnvObjectsWarehouseConveyorR2/Points/Marker2DSpawnPoint.global_position
	var dest_pos = $EnemyLayer/Row2/Covers/EnvObjectsWarehouseConveyorR2/Points/Marker2DDestinationPoint.global_position
	var env_object = scene.instantiate()
	env_object.position = spawn_pos
	env_object.dest_pos = dest_pos
	env_object.row_no = EnumRowNo.RowNo.ROW2
	env_object.scale = Vector2(0.5, 0.5)
	$EnemyLayer/Row2/Covers/EnvObjectsWarehouseConveyorR2.add_child(env_object)

func _move_conveyor(env_object_battery: Node, dest_pos: Vector2, delta: float):
	var direction = env_object_battery.position.direction_to(dest_pos)
	env_object_battery.position += direction * 200 * delta
	if env_object_battery.position.distance_to(dest_pos) < 3.0:
		env_object_battery.queue_free()

func _on_conveyor_belt_spawn_timer_timeout() -> void:
	spawn_object_conveyor_random()
	$Timers/ConveyorBeltSpawnTimer.start()

func _on_conveyor_belt_row_2_spawn_timer_timeout() -> void:
	spawn_object_conveyor_random_row2()
	$Timers/ConveyorBeltRow2SpawnTimer.start()
