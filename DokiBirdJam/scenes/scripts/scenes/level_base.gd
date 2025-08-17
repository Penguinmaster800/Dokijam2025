extends Node2D
class_name LevelParent

var reloading: bool = false
var enemy_bullet_scene: PackedScene = preload("res://scenes/objects/enemies/enemy_bullet.tscn")
var enemy_gunman_scene: PackedScene = preload("res://scenes/objects/enemies/enemy_gunman.tscn")
var enemy_brute_scene: PackedScene = preload("res://scenes/objects/enemies/enemy_brute.tscn")
var enemy_heavy_scene: PackedScene = preload("res://scenes/objects/enemies/enemy_heavy.tscn")
var enemy_sniper_scene: PackedScene = preload("res://scenes/objects/enemies/enemy_sniper.tscn")
var enemy_sniper_laser_scene: PackedScene = preload("res://scenes/objects/enemies/enemy_sniper_laser.tscn")
var enemy_stationary_scene: PackedScene = preload("res://scenes/objects/enemies/enemy_stationary.tscn")
var env_object_drone_scene: PackedScene = preload("res://scenes/objects/Environment/env_object_drone.tscn")
var env_object_drone_water_scene: PackedScene = preload("res://scenes/objects/Environment/env_object_water_drone.tscn")
var env_object_drone_electric_scene: PackedScene = preload("res://scenes/objects/Environment/env_object_electric_drone.tscn")
var env_effect_explosion_scene: PackedScene = preload("res://scenes/objects/Environment/env_effect_explosion.tscn")
var env_effect_water_scene: PackedScene = preload("res://scenes/objects/Environment/env_effect_water.tscn")
var env_effect_electric_scene: PackedScene = preload("res://scenes/objects/Environment/env_effect_electric.tscn")

var current_wave: int = 0
var total_waves: int = 0
var wave_in_progress: bool = false
var wave_enemy_count: int = 0

const AttackType = EnemyAttackType.AttackType
const EnemyType = EnumEnemyType.EnemyType
const EnvObjectType = EnumEnvObjectType.EnvObjectType

const level_1_beat = "res://scenes/levels/level_1_beat.tscn"
const level_2_beat = "res://scenes/levels/level_2_beat.tscn"
const level_3_beat = "res://scenes/levels/level_3_beat.tscn"


var explosion_drone = env_object_drone_scene
var water_drone = env_object_drone_water_scene
var electric_drone = env_object_drone_electric_scene
var random_drone := [explosion_drone, water_drone, electric_drone]

func level_startup():
	var vp = get_viewport()
	vp.set_physics_object_picking_sort(true)
	vp.set_physics_object_picking_first_only(true)
	Status.doki_ammo = Status.doki_max_ammo
	Status.last_bullet = true
	Status.doki_health = Status.doki_max_health
	Status.enemies_remaining_change.connect(_enemy_defeated)
	Status.doki_health_change.connect(_doki_hurt)
	Status.time_remaining_change.connect(_time_remaining_check)
	Status.doki_can_fire = true
	Status.doki_reloading = false
	Status.in_cover = false
	Status.doki_shot_cooldown = false
	Status.combo = 1
	print("ready")
	
func setup_enemy_waves(wave_count: int):
	total_waves = wave_count
	current_wave = 0
	start_new_wave()

func start_new_wave():
	if current_wave >= total_waves:
		return
	
	if wave_enemy_count >0:
		return
	
	wave_in_progress = true
	current_wave += 1
	print("Wave %s" % current_wave)
	spawn_wave(current_wave)

func spawn_wave(_wave_number: int):
	pass

func reload():
	if Status.doki_ammo < Status.doki_max_ammo and not Status.doki_reloading:
		$"Timers/Reload Timer".start()
		Status.doki_reloading = true
		Status.doki_can_fire = false
		AudioManager.doki_reload.play()
		print("reloading")

func _on_reload_timer_timeout() -> void:
	Status.doki_ammo = Status.doki_max_ammo
	Status.last_bullet = true
	reloading = false
	Status.doki_reloading = false
	Status.doki_can_fire = true
	
	print("reloading complete")

func _on_doki_reload_wait_timer_timeout() -> void:
	reload()

func _on_doki_fire_timer_timeout() -> void:
	Status.doki_shot_cooldown = true
	$Timers/DokiCooldownTimer.start()

func _on_doki_cooldown_timer_timeout() -> void:
	Status.doki_shot_cooldown = false

func _input(event):
	if event.is_action_pressed("primary action"):
		if Status.doki_ammo <= 0 and not reloading:
			Status.last_bullet = false
			AudioManager.doki_dry_fire.play()
			$Timers/DokiReloadWaitTimer.start()
		elif Status.doki_ammo >=1 and not reloading and Status.in_cover == false and Status.doki_shot_cooldown == false and Status.doki_exposed == true:
			AudioManager.doki_shoot.play()
			Status.doki_ammo -=1
			Status.doki_shot +=1
			$Timers/DokiFireTimer.start()
	
	if event.is_action_pressed("reload"):
		reload()
	
	if event.is_action_pressed("Ability 1"):
		if Abilities.ability1 == "Going Ghost":
			Abilities.going_ghost() 
		if Abilities.ability1 == "Red Eye":
			Abilities.red_eye()
		if Abilities.ability1 == "Aim Bot":
			Abilities.aim_bot()
		
	if event.is_action_pressed("Ability 2"):
		if Abilities.ability2 == "Going Ghost":
			Abilities.going_ghost() 
		if Abilities.ability2 == "Red Eye":
			Abilities.red_eye()
		if Abilities.ability2 == "Aim Bot":
			Abilities.aim_bot()
	if event.is_action_pressed("Ability 3"):
		if Abilities.ability3 == "Going Ghost":
			Abilities.going_ghost() 
		if Abilities.ability3 == "Red Eye":
			Abilities.red_eye()
		if Abilities.ability3 == "Aim Bot":
			Abilities.aim_bot()

func random_enemy_bullet_destination() -> Vector2:
	var rect_shape: RectangleShape2D = $EnemyProjectilesDestinationArea/CollisionShape2D.shape as RectangleShape2D
	var extents: Vector2 = rect_shape.size / 2.0
	var local_x = randf_range(-extents.x, extents.x)
	var local_y = randf_range(-extents.y, extents.y)
	return $EnemyProjectilesDestinationArea.global_position + Vector2(local_x, local_y)

func _on_enemy_enemy_attack(pos: Variant, type: AttackType) -> void:
	
	match type:
		AttackType.NORMAL:
			enemy_bullet_attack_default(pos)
		AttackType.SHOTGUN:
			enemy_bullet_attack_shotgun(pos)
		AttackType.SNIPER:
			enemy_bullet_attack_sniper(pos)
		_:
			enemy_bullet_attack_default(pos)
			
func _on_env_object_drone_box_explode(row_no: EnumRowNo.RowNo, pos: Vector2, is_shocked:bool = false) -> void:
	_spawn_explosive_effect(row_no, pos, is_shocked)

func _on_env_object_drone_box_drench(row_no: EnumRowNo.RowNo, pos: Vector2, is_wet:bool = false) -> void:
	_spawn_wet_effect(row_no, pos, is_wet)

func _on_env_object_drone_box_shock(row_no: EnumRowNo.RowNo, pos: Vector2, is_shocked:bool = false) -> void:
	_spawn_shock_effect(row_no, pos, is_shocked)

func _on_env_object_destroyed(object_type: EnumEnvObjectType.EnvObjectType, row_no: EnumRowNo.RowNo, pos: Vector2, is_shocked: bool, is_wet: bool):
	match object_type:
		EnumEnvObjectType.EnvObjectType.EXPLOSIVES:
			_spawn_explosive_effect(row_no, pos, is_shocked)
		EnumEnvObjectType.EnvObjectType.WATER:
			_spawn_wet_effect(row_no, pos, is_wet)
		EnumEnvObjectType.EnvObjectType.ELECTRIC:
			_spawn_shock_effect(row_no, pos, is_shocked)

func _spawn_explosive_effect(row_no: EnumRowNo.RowNo, pos: Vector2, is_shocked:bool = false):
	var env_effect_explosion = env_effect_explosion_scene.instantiate()
	env_effect_explosion.global_position = pos
	env_effect_explosion.row_no = row_no
	if is_shocked == true:
		env_effect_explosion.scale.x = 3
		env_effect_explosion.scale.y = 2
	if is_shocked == false:
		env_effect_explosion.scale.x = 1
	$Projectiles.add_child(env_effect_explosion)

func _spawn_shock_effect(row_no: EnumRowNo.RowNo, pos: Vector2, is_shocked:bool = false):
	var env_effect_electric = env_effect_electric_scene.instantiate()
	env_effect_electric.global_position = pos
	env_effect_electric.row_no = row_no
	if is_shocked == true:
		env_effect_electric.scale.x = 3
		env_effect_electric.scale.y = 3
	if is_shocked == false:
		env_effect_electric.scale.x = 2
		env_effect_electric.scale.y = 2
	$Projectiles.add_child(env_effect_electric)

func _spawn_wet_effect(row_no: EnumRowNo.RowNo, pos: Vector2, is_wet: bool = false):
	var env_effect_water = env_effect_water_scene.instantiate()
	env_effect_water.global_position = pos
	env_effect_water.row_no = row_no
	if is_wet == true:
		env_effect_water.scale.x = 3
	if is_wet == false:
		env_effect_water.scale.x = 2
	$Projectiles.add_child(env_effect_water)

func enemy_bullet_attack_default(pos: Variant) -> void:
	var enemy_bullet = enemy_bullet_scene.instantiate()
	enemy_bullet.position = pos

	var dest = random_enemy_bullet_destination()
	enemy_bullet.destination = dest
	
	$Projectiles.add_child(enemy_bullet)

func enemy_bullet_attack_shotgun(pos: Variant) -> void:
	var bullets_per_shot: int = 3
	var spread_angle_degrees: float = -15.0
	var spread_radians = deg_to_rad(spread_angle_degrees)
	var base_dest = random_enemy_bullet_destination()

	for i in range(bullets_per_shot):
		var enemy_bullet = enemy_bullet_scene.instantiate()
		enemy_bullet.position = pos

		var angle_step = spread_radians / (bullets_per_shot - 1) if bullets_per_shot > 1 else 0.0
		var bullet_angle = i * angle_step

		var base_direction = (base_dest - pos).normalized()
		var rotated_direction = base_direction.rotated(bullet_angle)
		
		var y_diff = base_dest.y - pos.y
		var distance = y_diff / rotated_direction.y if rotated_direction.y != 0 else 800.0
		
		enemy_bullet.destination = pos + (rotated_direction * distance)
		
		$Projectiles.add_child(enemy_bullet)

func enemy_bullet_attack_sniper(pos: Variant) -> void:
	var enemy_bullet = enemy_bullet_scene.instantiate()
	enemy_bullet.position = pos

	#var dest: Vector2 = random_enemy_bullet_destination()
	var dest = $Player/PlayerHitbox.global_position
	enemy_bullet.destination = dest
	enemy_bullet.damage = 3
	
	$Projectiles.add_child(enemy_bullet)

func spawn_enemy_gunman(row_no: EnumRowNo.RowNo):
	spawn_enemy(enemy_gunman_scene, EnemyType.GUNMAN, row_no)

func spawn_enemy_gunman_random_row():
	spawn_enemy_random_row(enemy_gunman_scene, EnemyType.GUNMAN)

func spawn_enemy_brute(row_no: EnumRowNo.RowNo):
	spawn_enemy(enemy_brute_scene, EnemyType.BRUTE, row_no)

func spawn_enemy_brute_random_row():
	spawn_enemy_random_row(enemy_brute_scene, EnemyType.BRUTE)
	
func spawn_enemy_heavy(row_no: EnumRowNo.RowNo):
	spawn_enemy(enemy_heavy_scene, EnemyType.HEAVY, row_no)

func spawn_enemy_heavy_random_row():
	spawn_enemy_random_row(enemy_heavy_scene, EnemyType.BRUTE)

func spawn_enemy_sniper(row_no: EnumRowNo.RowNo):
	spawn_enemy(enemy_sniper_scene, EnemyType.SNIPER, row_no)

func spawn_enemy_sniper_random_row():
	spawn_enemy_random_row(enemy_sniper_scene, EnemyType.SNIPER)
	
func spawn_enemy_stationary(row_no: EnumRowNo.RowNo):
	spawn_enemy(enemy_stationary_scene, EnemyType.STATIONARY, row_no)
	
func spawn_enemy_stationary_random_row():
	spawn_enemy_random_row(enemy_stationary_scene, EnemyType.STATIONARY)

func spawn_enemy_random_row(enemy_scene: PackedScene, enemy_type: EnemyType):
	var available_rows = get_rows_with_available_cover()
	if available_rows.size() > 0:
		var target_row = available_rows.pick_random()
		spawn_enemy(enemy_scene, enemy_type, target_row)

func spawn_enemy(enemy_scene: PackedScene, enemy_type: EnemyType, row_no: EnumRowNo.RowNo):
	var row = get_row_no_instance(row_no)

	var spawn_point: SpawnPointData = row.spawn_points.pick_random()
	
	var enemy = enemy_scene.instantiate()
	enemy.position = spawn_point.spawn_point_positions[0]

	enemy.enemy_attack.connect(_on_enemy_enemy_attack)

	if enemy_type != EnemyType.STATIONARY:
		var available_cover_points = row.get_available_cover_points()
		if available_cover_points.size() <= 0:
			print("No available points :(")
			return
		
		var cover_point: CoverPointData = available_cover_points.pick_random()
		cover_point.is_available = false
		
		enemy.cover_point = cover_point
		enemy.spawn_move_position = cover_point.in_cover_positions[0]

		enemy.enemy_death.connect(_on_enemy_death.bind(cover_point))
	

	if enemy_type == EnemyType.SNIPER:
		var enemy_sniper_laser = enemy_sniper_laser_scene.instantiate()

		enemy_sniper_laser.player = $Player
		enemy_sniper_laser.enemy = enemy
		$Projectiles.add_child(enemy_sniper_laser)
		enemy.aiming.connect(enemy_sniper_laser.start_aiming)
		enemy.stop_aiming.connect(enemy_sniper_laser.stop_aiming)
		enemy.enemy_death.connect(enemy_sniper_laser.stop_aiming)
	
	if enemy_type == EnemyType.STATIONARY:
		enemy.stationary_position = row.stationary_points.pick_random()
	
	row.get_node("Enemies").add_child(enemy)

func _on_enemy_death(cover_point: CoverPointData):
	cover_point.is_available = true

func spawn_env_object_drone(row_no: EnumRowNo.RowNo, type= null):
	if type == null:
		random_drone.shuffle()
		type = random_drone[0]
		if type == explosion_drone:
			spawn_env_object(type, EnvObjectType.DRONE, row_no)
		if type == water_drone:
			spawn_env_object(type, EnvObjectType.WATER_DRONE, row_no)
		if type == electric_drone:
			spawn_env_object(type, EnvObjectType.ELECTRIC_DRONE, row_no)
	if type == explosion_drone:
		spawn_env_object(type, EnvObjectType.DRONE, row_no)
	if type == water_drone:
		spawn_env_object(type, EnvObjectType.WATER_DRONE, row_no)
	if type == electric_drone:
		spawn_env_object(type, EnvObjectType.ELECTRIC_DRONE, row_no)

func spawn_env_object(env_object_scene: PackedScene, env_object_type: EnvObjectType, row_no: EnumRowNo.RowNo):
	var env_object = env_object_scene.instantiate()
	var row = get_row_no_instance(row_no)
	var spawn_point: SpawnPointData = row.spawn_points.pick_random()
	env_object.position = spawn_point.spawn_point_positions[0]
	env_object.row_no = row_no
	if env_object_type == EnvObjectType.DRONE:
		env_object.get_node("EnvObjectDroneBox").explode.connect(_on_env_object_drone_box_explode)
	if env_object_type == EnvObjectType.WATER_DRONE:
		env_object.get_node("EnvObjectDroneBox").drench.connect(_on_env_object_drone_box_drench)
	if env_object_type == EnvObjectType.ELECTRIC_DRONE:
		env_object.get_node("EnvObjectDroneBox").shock.connect(_on_env_object_drone_box_shock)

	row.get_node("EnvObjects").add_child(env_object)

func get_row_no_instance(row: EnumRowNo.RowNo) -> Node:
	match row:
		EnumRowNo.RowNo.ROW1: 
			return $EnemyLayer/Row1
		EnumRowNo.RowNo.ROW2: 
			return $EnemyLayer/Row2
		EnumRowNo.RowNo.ROW3:
			return $EnemyLayer/Row3
		EnumRowNo.RowNo.ROW4:
			return $EnemyLayer/Row4
		_:
			return $EnemyLayer/Row1

func get_rows_with_available_cover() -> Array[EnumRowNo.RowNo]:
	var available_rows: Array[EnumRowNo.RowNo] = []
	var all_rows = [EnumRowNo.RowNo.ROW1, EnumRowNo.RowNo.ROW2, EnumRowNo.RowNo.ROW3, EnumRowNo.RowNo.ROW4]
	
	for row_no in all_rows:
		var row = get_row_no_instance(row_no)
		if row.has_available_cover_points():
			available_rows.append(row_no)

	return available_rows
	
func _enemy_defeated():
	print("dragoon down")
	Status.score += 100 * (Status.combo)
	Status.combo += 0.1
	print(Status.combo)
	wave_enemy_count -= 1
	if Status.enemies_remaining >= 1:
		pass
	if Status.enemies_remaining <= 0:
		print("victory")
		level_beat()
	if current_wave < total_waves and wave_enemy_count <= 0:
		$Timers/EnemyWaveCooldownTimer.start()

func _doki_hurt():
	print("doki hit")
	if Status.doki_health >= 1:
		pass
	if Status.doki_health <= 0:
		print("death")
		level_loss()

func _time_remaining_check():
	if Status.time_remaining <=0:
		level_loss()

func level_loss():
	TransitionLayer.change_scene("res://scenes/levels/game_over.tscn")

func level_beat():
	Status.level += 1
	if Status.level == 2:
		TransitionLayer.change_scene(level_1_beat)
	if Status.level == 3:
		TransitionLayer.change_scene(level_2_beat)
	if Status.level == 4:
		TransitionLayer.change_scene(level_3_beat)

func _on_enemy_wave_cooldown_timer_timeout() -> void:
	start_new_wave()
