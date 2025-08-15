extends Node

#Level Music
@onready var level_one_music: AudioStreamPlayer2D = $LevelOneMusic
@onready var game_over_music: AudioStreamPlayer2D = $GameOverMusic
@onready var level_two_music: AudioStreamPlayer2D = $LevelTwoMusic
@onready var level_three_music: AudioStreamPlayer2D = $LevelThreeMusic

#Doki Sounds
@onready var doki_shoot: AudioStreamPlayer2D = $DokiShoot
@onready var doki_dry_fire: AudioStreamPlayer2D = $DokiDryFire
@onready var doki_reload: AudioStreamPlayer2D = $DokiReload

# Enemy Sounds
@onready var enemy_death: AudioStreamPlayer2D = $EnemyDeath
