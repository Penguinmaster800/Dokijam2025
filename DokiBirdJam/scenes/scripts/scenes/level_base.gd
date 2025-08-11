extends Node2D
class_name LevelParent

var reloading: bool = false
var enemy_bullet_scene: PackedScene = preload("res://scenes/objects/enemies/enemy_bullet.tscn")
var enemy_gunman_scene: PackedScene = preload("res://scenes/objects/enemies/enemy_gunman.tscn")
var enemy_brute_scene: PackedScene = preload("res://scenes/objects/enemies/enemy_brute.tscn")
var enemy_sniper_scene: PackedScene = preload("res://scenes/objects/enemies/enemy_sniper.tscn")
var enemy_sniper_laser_scene: PackedScene = preload("res://scenes/objects/enemies/enemy_sniper_laser.tscn")
var env_object_drone_scene: PackedScene = preload("res://scenes/objects/Environment/env_object_drone.tscn")
var env_effect_explosion_scene: PackedScene = preload("res://scenes/objects/Environment/env_effect_explosion.tscn")
var env_effect_water_scene: PackedScene = preload("res://scenes/objects/Environment/env_effect_water.tscn")

const AttackType = EnemyAttackType.AttackType
const EnemyType = EnumEnemyType.EnemyType
const EnvObjectType = EnumEnvObjectType.EnvObjectType

const level_1_beat = "res://scenes/levels/level_1_beat.tscn"
const level_2_beat = "res://scenes/levels/level_2_beat.tscn"
const level_3_beat = "res://scenes/levels/level_3_beat.tscn"

func level_startup():
	var vp = get_viewport()
	vp.set_physics_object_picking_sort(true)
	vp.set_physics_object_picking_first_only(true)
	Status.doki_ammo = Status.doki_max_ammo
	Status.doki_health = Status.doki_max_health
	Status.enemies_remaining_change.connect(_enemy_defeated)
	Status.doki_health_change.connect(_doki_hurt)
	Status.time_remaining_change.connect(_time_remaining_check)
	Status.doki_can_fire = true
	Status.doki_reloading = false
	Status.in_cover = false
	Status.doki_shot_cooldown = false
	
	print("ready")

func reload():
	if Status.doki_ammo < Status.doki_max_ammo and not Status.doki_reloading:
		$"Timers/Reload Timer".start()
		Status.doki_reloading = true
		Status.doki_can_fire = false
		AudioManager.doki_reload.play()
		print("reloading")

func _on_reload_timer_timeout() -> void:
	Status.doki_ammo = Status.doki_max_ammo
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
			AudioManager.doki_dry_fire.play()
			$Timers/DokiReloadWaitTimer.start()
		elif Status.doki_ammo >=1 and not reloading and Status.in_cover == false and Status.doki_shot_cooldown == false:
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
		if Abilities.ability3 == "Aim Bot":
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
			
func _on_env_object_drone_box_explode(row_no: EnumRowNo.RowNo, pos: Vector2) -> void:
	var env_effect_explosion = env_effect_explosion_scene.instantiate()
	env_effect_explosion.global_position = pos
	env_effect_explosion.row_no = row_no
	$Projectiles.add_child(env_effect_explosion)

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

	var dest: Vector2 = random_enemy_bullet_destination()
	dest = $Player.global_position
	enemy_bullet.destination = dest
	
	$Projectiles.add_child(enemy_bullet)

func spawn_enemy_gunman(row_no: EnumRowNo.RowNo):
	spawn_enemy(enemy_gunman_scene, EnemyType.GUNMAN, row_no)

func spawn_enemy_brute(row_no: EnumRowNo.RowNo):
	spawn_enemy(enemy_brute_scene, EnemyType.BRUTE, row_no)
	
func spawn_enemy_sniper(row_no: EnumRowNo.RowNo):
	spawn_enemy(enemy_sniper_scene, EnemyType.SNIPER, row_no)

func spawn_enemy(enemy_scene: PackedScene, enemy_type: EnemyType, row_no: EnumRowNo.RowNo):
	var row = get_row_no_instance(row_no)
	var cover_point: CoverPointData = row.cover_points.pick_random()
	var spawn_point: SpawnPointData = row.spawn_points.pick_random()
	
	var enemy = enemy_scene.instantiate()
	enemy.position = spawn_point.spawn_point_positions[0]
	enemy.cover_point = cover_point
	enemy.spawn_move_position = cover_point.in_cover_positions[0]
	enemy.enemy_attack.connect(_on_enemy_enemy_attack)

	if enemy_type == EnemyType.SNIPER:
		var enemy_sniper_laser = enemy_sniper_laser_scene.instantiate()

		enemy_sniper_laser.player = $Player
		enemy_sniper_laser.enemy = enemy
		$Projectiles.add_child(enemy_sniper_laser)
		enemy.aiming.connect(enemy_sniper_laser.start_aiming)
		enemy.stop_aiming.connect(enemy_sniper_laser.stop_aiming)
		enemy.enemy_death.connect(enemy_sniper_laser.stop_aiming)
	
	row.get_node("Enemies").add_child(enemy)

func spawn_env_object_drone(row_no: EnumRowNo.RowNo):
	spawn_env_object(env_object_drone_scene, EnvObjectType.DRONE, row_no)

func spawn_env_object(env_object_scene: PackedScene, env_object_type: EnvObjectType, row_no: EnumRowNo.RowNo):
	var env_object = env_object_scene.instantiate()
	var row = get_row_no_instance(row_no)
	var spawn_point: SpawnPointData = row.spawn_points.pick_random()
	env_object.position = spawn_point.spawn_point_positions[0]
	env_object.row_no = row_no
	
	if env_object_type == EnvObjectType.DRONE:
		env_object.get_node("EnvObjectDroneBox").explode.connect(_on_env_object_drone_box_explode)

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
		
func _enemy_defeated():
	print("dragoon down")
	if Status.enemies_remaining >= 1:
		pass
	if Status.enemies_remaining <= 0:
		print("victory")
		level_beat()

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
