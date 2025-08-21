extends AbilityButton
var time = Abilities.going_ghost_time_remaining

func _ready():
	cooldown = Abilities.going_ghost_cooldown_time
	Abilities.going_ghost_activate.connect(_going_ghost)
	Abilities.going_ghost_time_remaining_change.connect(_update_ready)
	Abilities.going_ghost_ready = true
	Abilities.going_ghost_time_remaining = 0
	super._ready()

func _process(delta):
	if Abilities.going_ghost_time_remaining > cooldown :
			Abilities.going_ghost_time_remaining = 0
			Abilities.going_ghost_ready = true
			$ReadyTracker/TimeRemaining.text = "Ready"
			$ReadyTracker/InputKey/Panel.modulate = Color(1,1,1)
	if Abilities.going_ghost_time_remaining <= cooldown && Abilities.going_ghost_time_remaining != 0:
			time = Abilities.going_ghost_time_remaining
			time += delta 
			Abilities.going_ghost_time_remaining = time
			sec = absi($ReadyTracker.value-cooldown)
			if sec == 0:
				$ReadyTracker/TimeRemaining.text = "Ready"
				$ReadyTracker/InputKey/Panel.modulate = Color(1,1,1)
			else:
				$ReadyTracker/TimeRemaining.text = str(sec)
				$ReadyTracker/InputKey/Panel.modulate = Color(0.282, 0.282, 0.282)

func _going_ghost():
	Abilities.going_ghost_time_remaining = .1
	Abilities.going_ghost_ready = false

func _update_ready():
	if Abilities.going_ghost_time_remaining != 0:
		$ReadyTracker.value = Abilities.going_ghost_time_remaining
