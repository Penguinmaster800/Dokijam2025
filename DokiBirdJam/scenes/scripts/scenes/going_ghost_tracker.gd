extends Control
var time = Abilities.going_ghost_time_remaining
var sec: int = 0
@export var cooldown: int = 25

func _ready():
	Abilities.going_ghost_activate.connect(_going_ghost)
	Abilities.going_ghost_time_remaining_change.connect(_update_ready)
	Abilities.going_ghost_ready = true
	Abilities.going_ghost_time_remaining = 0
	$ReadyTracker.max_value = cooldown
	$ReadyTracker.value = $ReadyTracker.max_value
	$ReadyTracker/TimeRemaining.text = "Ready"


func _process(delta):
	if Abilities.going_ghost_time_remaining > cooldown :
			Abilities.going_ghost_time_remaining = 0
			Abilities.going_ghost_ready = true
			$ReadyTracker/TimeRemaining.text = "Ready"
	if Abilities.going_ghost_time_remaining <= cooldown && Abilities.going_ghost_time_remaining != 0:
			time = Abilities.going_ghost_time_remaining
			time += delta 
			Abilities.going_ghost_time_remaining = time
			sec = absi($ReadyTracker.value-cooldown)
			if sec == 0:
				$ReadyTracker/TimeRemaining.text = "Ready"
			else:
				$ReadyTracker/TimeRemaining.text = str(sec)


func _going_ghost():
	Abilities.going_ghost_time_remaining = .1
	Abilities.going_ghost_ready = false

func _update_ready():
	$ReadyTracker.value = Abilities.going_ghost_time_remaining
