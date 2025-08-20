class_name AbilityButton extends Control

var keybind: String = ""
var sec: int = 0
var cooldown: int = 0

func _ready() -> void:
	$ReadyTracker.max_value = cooldown
	$ReadyTracker.value = $ReadyTracker.max_value
	$ReadyTracker/TimeRemaining.text = "Ready"
	$ReadyTracker/InputKey/Panel/Label.text = keybind
