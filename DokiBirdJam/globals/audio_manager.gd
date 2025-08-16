extends Node


#Level Music
@onready var game_over_music: AudioStreamPlayer2D = $Music/GameOverMusic
@onready var level_one_music: AudioStreamPlayer2D = $Music/LevelOneMusic
@onready var level_two_music: AudioStreamPlayer2D = $Music/LevelTwoMusic
@onready var level_three_music: AudioStreamPlayer2D = $Music/LevelThreeMusic
@onready var main_menu_music: AudioStreamPlayer2D = $Music/MainMenuMusic
@onready var thank_you_for_playing_credits_: AudioStreamPlayer2D = $"Music/ThankYouForPlaying(credits)"
@onready var intermission_music: AudioStreamPlayer2D = $Music/IntermissionMusic



#Doki Sounds
@onready var doki_shoot: AudioStreamPlayer2D = $DokiSounds/DokiShoot
@onready var doki_fan_the_hammer: AudioStreamPlayer2D = $DokiSounds/DokiFanTheHammer
@onready var doki_reload: AudioStreamPlayer2D = $DokiSounds/DokiReload
@onready var doki_dry_fire: AudioStreamPlayer2D = $DokiSounds/DokiDryFire
@onready var doki_red_eye: AudioStreamPlayer2D = $DokiSounds/DokiRedEye
@onready var doki_going_ghost: AudioStreamPlayer2D = $DokiSounds/DokiGoingGhost




# Enemy Sounds
@onready var enemy_death: AudioStreamPlayer2D = $EnemySounds/EnemyDeath
@onready var enemy_sniper_shot: AudioStreamPlayer2D = $EnemySounds/EnemySniperShot
@onready var enemy_shot_1: AudioStreamPlayer2D = $EnemySounds/EnemyShot1
@onready var enemy_shot_2: AudioStreamPlayer2D = $EnemySounds/EnemyShot2
@onready var enemy_shotgun_shot: AudioStreamPlayer2D = $EnemySounds/EnemyShotgunShot


#doki hit sounds

@onready var dgj_doki_injured_1: AudioStreamPlayer2D = $DokiInjuries/DgjDokiInjured1
@onready var dgj_doki_injured_2: AudioStreamPlayer2D = $DokiInjuries/DgjDokiInjured2
@onready var dgj_doki_injured_3: AudioStreamPlayer2D = $DokiInjuries/DgjDokiInjured3
@onready var dgj_doki_injured_4: AudioStreamPlayer2D = $DokiInjuries/DgjDokiInjured4
@onready var dgj_doki_injured_5_1: AudioStreamPlayer2D = $DokiInjuries/DgjDokiInjured5_1
@onready var dgj_doki_injured_6: AudioStreamPlayer2D = $DokiInjuries/DgjDokiInjured6
@onready var dgj_doki_injured_7: AudioStreamPlayer2D = $DokiInjuries/DgjDokiInjured7
@onready var dgj_doki_injured_8: AudioStreamPlayer2D = $DokiInjuries/DgjDokiInjured8
@onready var dgj_doki_injured_9: AudioStreamPlayer2D = $DokiInjuries/DgjDokiInjured9
@onready var dgj_doki_injured_10: AudioStreamPlayer2D = $DokiInjuries/DgjDokiInjured10
@onready var dgj_doki_nonverbal_damage_taken_1: AudioStreamPlayer2D = $DokiInjuries/DgjDokiNonverbalDamageTaken1
@onready var dgj_doki_nonverbal_damage_taken_2: AudioStreamPlayer2D = $DokiInjuries/DgjDokiNonverbalDamageTaken2
