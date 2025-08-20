extends AbilityButton
var time = Abilities.red_eye_time_remaining

func _ready():
	cooldown = Abilities.red_eye_cooldown_time
	Abilities.red_eye_activate.connect(_red_eye)
	Abilities.red_eye_time_remaining_change.connect(_update_ready)
	Abilities.red_eye_ready = true
	Abilities.red_eye_time_remaining = 0
	super._ready()

func _process(delta):
	if Abilities.red_eye_time_remaining > cooldown :
			Abilities.red_eye_time_remaining = 0
			Abilities.red_eye_ready = true
			$ReadyTracker/TimeRemaining.text = "Ready"
			$ReadyTracker/InputKey/Panel.modulate = Color(1,1,1)
	if Abilities.red_eye_time_remaining <= cooldown && Abilities.red_eye_time_remaining != 0:
			time = Abilities.red_eye_time_remaining
			time += delta 
			Abilities.red_eye_time_remaining = time
			sec = absi($ReadyTracker.value-cooldown)
			if sec == 0:
				$ReadyTracker/TimeRemaining.text = "Ready"
				$ReadyTracker/InputKey/Panel.modulate = Color(1,1,1)
			else:
				$ReadyTracker/TimeRemaining.text = str(sec)
				$ReadyTracker/InputKey/Panel.modulate = Color(0.282, 0.282, 0.282)

func _red_eye():
	Abilities.red_eye_time_remaining = .1
	Abilities.red_eye_ready = false

func _update_ready():
	if Abilities.red_eye_time_remaining != 0:
		$ReadyTracker.value = Abilities.red_eye_time_remaining
