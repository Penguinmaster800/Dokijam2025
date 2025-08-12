extends Control
var time = Abilities.aim_bot_time_remaining
var sec: int = 0
@export var cooldown: int = 45

func _ready():
	Abilities.aim_bot_activate.connect(_aim_bot)
	Abilities.aim_bot_time_remaining_change.connect(_update_ready)
	Abilities.aim_bot_ready = true
	Abilities.aim_bot_time_remaining = 0
	$ReadyTracker.max_value = cooldown
	$ReadyTracker.value = $ReadyTracker.max_value
	$ReadyTracker/TimeRemaining.text = "Ready"



func _process(delta):
	if Abilities.aim_bot_time_remaining > cooldown :
			Abilities.aim_bot_time_remaining = 0
			$ReadyTracker/TimeRemaining.text = "Ready"
			Abilities.aim_bot_ready = true
	if Abilities.aim_bot_time_remaining <= cooldown && Abilities.aim_bot_time_remaining != 0:
			time = Abilities.aim_bot_time_remaining
			time += delta 
			Abilities.aim_bot_time_remaining = time
			sec = absi($ReadyTracker.value-cooldown)
			if sec == 0:
				$ReadyTracker/TimeRemaining.text = "Ready"
			else:
				$ReadyTracker/TimeRemaining.text = str(sec)


func _aim_bot():
	Abilities.aim_bot_time_remaining = .1
	Abilities.aim_bot_ready = false

func _update_ready():
	$ReadyTracker.value = Abilities.aim_bot_time_remaining
