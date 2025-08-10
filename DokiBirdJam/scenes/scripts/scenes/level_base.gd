extends Node2D
class_name LevelParent

var reloading: bool = false
var enemy_bullet_scene: PackedScene = preload("res://scenes/objects/enemies/enemy_bullet.tscn")
var enemy_gunman_scene: PackedScene = preload("res://scenes/objects/enemies/enemy_gunman.tscn")
var enemy_brute_scene: PackedScene = preload("res://scenes/objects/enemies/enemy_brute.tscn")
var enemy_sniper_scene: PackedScene = preload("res://scenes/objects/enemies/enemy_sniper.tscn")
var enemy_sniper_laser_scene: PackedScene = preload("res://scenes/objects/enemies/enemy_sniper_laser.tscn")
const AttackType = EnemyAttackType.AttackType
const EnemyType = EnumEnemyType.EnemyType
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
	
	print("ready")

func reload():
	if Status.doki_reloading == true:
		pass
	if Status.doki_ammo == Status.doki_max_ammo:
		pass
	if Status.doki_ammo < Status.doki_max_ammo and not Status.doki_reloading:
		$"Reload Timer".start()
		Status.doki_reloading = true
		Status.doki_can_fire = false
		print("reloading")

func _on_reload_timer_timeout() -> void:
	Status.doki_ammo = Status.doki_max_ammo
	reloading = false
	Status.doki_reloading = false
	Status.doki_can_fire = true
	print("reloading complete")


func _input(event):
	if event.is_action_pressed("primary action"):
		if Status.doki_ammo <= 0 and not reloading:
			#play sound of no ammo
			reload()
		elif  Status.doki_ammo >=1 and not reloading and Status.in_cover == false:
			#play fire sound
			Status.doki_ammo -=1
			#send damage signal
		
	if event.is_action_pressed("reload"):
		reload()
	
	if event.is_action_pressed("Ability 1"):
		Abilities.ability1
	if event.is_action_pressed("Ability 2"):
		Abilities.ability2
	if event.is_action_pressed("Ability 3"):
		Abilities.ability3

func random_enemy_bullet_destination() -> Vector2:
	var rect_shape: RectangleShape2D = $EnemyProjectilesDestinationArea/CollisionShape2D.shape as RectangleShape2D
	var extents: Vector2 = rect_shape.size / 2.0
	var local_x = randf_range(-extents.x, extents.x)
	var local_y = randf_range(-extents.y, extents.y)
	return $EnemyProjectilesDestinationArea.global_position + Vector2(local_x, local_y)

#func _on_enemy_sniper_aiming() -> void:
	#

func _on_enemy_enemy_attack(pos: Variant, type: AttackType) -> void:
	
	match type:
		AttackType.NORMAL:
			enemy_bullet_attack_default(pos)
		AttackType.SHOTGUN:
			enemy_bullet_attack_shotgun(pos)
		_:
			enemy_bullet_attack_default(pos)

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

func spawn_enemy_gunman(row_no: int):
	spawn_enemy(enemy_gunman_scene, EnemyType.GUNMAN, row_no)

func spawn_enemy_brute(row_no: int):
	spawn_enemy(enemy_brute_scene, EnemyType.BRUTE, row_no)
	
func spawn_enemy_sniper(row_no: int):
	spawn_enemy(enemy_sniper_scene, EnemyType.SNIPER, row_no)

func spawn_enemy(enemy_scene: PackedScene, enemy_type: EnemyType, row_no: int):
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

func get_row_no_instance(row: int) -> Node:
	match row:
		1: 
			return $EnemyLayer/Row1
		2: 
			return $EnemyLayer/Row2
		3:
			return $EnemyLayer/Row3
		4:
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
