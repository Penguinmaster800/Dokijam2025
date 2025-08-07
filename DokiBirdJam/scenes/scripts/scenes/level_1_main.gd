extends LevelParent

func _ready():
	Status.enemies_remaining = 12
	Status.time_remaining = 80
	spawn_enemy_gunman(Vector2(600,300))
	spawn_enemy_brute(Vector2(800,200))
