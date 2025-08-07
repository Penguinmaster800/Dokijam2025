extends Panel

var time = Status.time_remaining
var sec: int = 0
var min: int = 0
var msec: int = 0

func _process(delta):
	time = Status.time_remaining
	time -= delta
	Status.time_remaining = time
	msec =fmod(time,1) * 1000
	sec = fmod(time, 60)
	min = fmod(time, 3600) / 60
	
	$minute.text = "%02d:" % min
	$second.text = "%02d." % sec
	$milisecond.text = "%03d" % msec
