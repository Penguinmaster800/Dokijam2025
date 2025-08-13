extends Control

var score = Status.score
var combo = Status.combo
var highScore = Status.highScore

func _ready():
	Status.score_change.connect(_score_update)
	Status.combo_change.connect(_combo_change)
	Status.highScore_change.connect(_highScore_change)

func _process(_delta) -> void:
	$ProgressBar.value -=.018

func _score_update():
	score = Status.score
	highScore = Status.highScore
	$ScorePanel/VBoxContainer/CurrentScore.text = "Current Score: %d." % score
	if score >= Status.highScore:
		Status.highScore = score

func _combo_change():
	combo = Status.combo
	$ScorePanel/VBoxContainer/Multiplier.text = "Multiplier: %.1f" % combo
	$HighScoreTimer.start()
	if Status.combo > 1:
		$ProgressBar.value = 5

func _highScore_change():
	highScore = Status.highScore
	$ScorePanel/VBoxContainer/HighScore.text = "High score: %d." % highScore


func _on_high_score_timer_timeout() -> void:
	Status.combo = 1
