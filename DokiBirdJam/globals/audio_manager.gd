extends Node

#Level Music
@onready var game_over_music: AudioStreamPlayer2D = $Music/GameOverMusic
@onready var level_one_music: AudioStreamPlayer2D = $Music/LevelOneMusic
@onready var level_two_music: AudioStreamPlayer2D = $Music/LevelTwoMusic
@onready var level_three_music: AudioStreamPlayer2D = $Music/LevelThreeMusic


#Doki Sounds
@onready var doki_shoot: AudioStreamPlayer2D = $DokiSounds/DokiShoot
@onready var doki_fan_the_hammer: AudioStreamPlayer2D = $DokiSounds/DokiFanTheHammer
@onready var doki_reload: AudioStreamPlayer2D = $DokiSounds/DokiReload
@onready var doki_dry_fire: AudioStreamPlayer2D = $DokiSounds/DokiDryFire




# Enemy Sounds
@onready var enemy_death: AudioStreamPlayer2D = $EnemySounds/EnemyDeath
@onready var enemy_sniper_shot: AudioStreamPlayer2D = $EnemySounds/EnemySniperShot
@onready var enemy_shot_1: AudioStreamPlayer2D = $EnemySounds/EnemyShot1
@onready var enemy_shot_2: AudioStreamPlayer2D = $EnemySounds/EnemyShot2
@onready var enemy_shotgun_shot: AudioStreamPlayer2D = $EnemySounds/EnemyShotgunShot
