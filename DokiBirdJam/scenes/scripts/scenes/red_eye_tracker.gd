extends Control
var time = Abilities.red_eye_time_remaining
var sec: int = 0
@export var cooldown: int = 35

func _ready():
	Abilities.red_eye_activate.connect(_red_eye)
	Abilities.red_eye_time_remaining_change.connect(_update_ready)
	Abilities.red_eye_ready = true
	Abilities.red_eye_time_remaining = 0
	$ReadyTracker.max_value = cooldown
	$ReadyTracker.value = $ReadyTracker.max_value
	$ReadyTracker/TimeRemaining.text = "Ready"



func _process(delta):
	if Abilities.red_eye_time_remaining > cooldown :
			Abilities.red_eye_time_remaining = 0
			$ReadyTracker/TimeRemaining.text = "Ready"
			Abilities.red_eye_ready = true
	if Abilities.red_eye_time_remaining <= cooldown && Abilities.red_eye_time_remaining != 0:
			time = Abilities.red_eye_time_remaining
			time += delta 
			Abilities.red_eye_time_remaining = time
			sec = absi($ReadyTracker.value-cooldown)
			if sec == 0:
				$ReadyTracker/TimeRemaining.text = "Ready"
			else:
				$ReadyTracker/TimeRemaining.text = str(sec)


func _red_eye():
	Abilities.red_eye_time_remaining = .1
	Abilities.red_eye_ready = false

func _update_ready():
	if Abilities.red_eye_time_remaining != 0:
		$ReadyTracker.value = Abilities.red_eye_time_remaining
