extends AbilityButton
var time = Abilities.aim_bot_time_remaining

func _ready():
	cooldown = Abilities.aim_bot_cooldown_time
	Abilities.aim_bot_activate.connect(_aim_bot)
	Abilities.aim_bot_time_remaining_change.connect(_update_ready)
	Abilities.aim_bot_ready = true
	Abilities.aim_bot_time_remaining = 0
	super._ready()

func _process(delta):

	if Abilities.aim_bot_ready:
		if Status.doki_ammo < 6:
			$ReadyTracker/TimeRemaining.text = "Reload!"
			$ReadyTracker/InputKey/Panel.modulate = Color(0.282, 0.282, 0.282)
		else:
			$ReadyTracker/TimeRemaining.text = "Ready"
			$ReadyTracker/InputKey/Panel.modulate = Color(1,1,1)
		return
	
	if Abilities.aim_bot_time_remaining >= cooldown :
		Abilities.aim_bot_time_remaining = 0
		Abilities.aim_bot_ready = true

	if Abilities.aim_bot_time_remaining < cooldown && Abilities.aim_bot_time_remaining != 0:
		time = Abilities.aim_bot_time_remaining
		time += delta 
		Abilities.aim_bot_time_remaining = time
		sec = absi($ReadyTracker.value-cooldown)
		$ReadyTracker/TimeRemaining.text = str(sec)
		$ReadyTracker/InputKey/Panel.modulate = Color(0.282, 0.282, 0.282)

func _aim_bot():
	Abilities.aim_bot_time_remaining = .1
	Abilities.aim_bot_ready = false

func _update_ready():
	if Abilities.aim_bot_time_remaining != 0:
		$ReadyTracker.value = Abilities.aim_bot_time_remaining
