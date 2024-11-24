class_name ScoreUI extends CanvasLayer

@onready var DistanceValueLabel: Label = $DistanceValueLabel
@onready var TimeLeftValueLabel: Label = $TimeLeftValueLabel

var time_left: int = 0

func _process(delta: float) -> void:
	var time_str = time_left / 1000
	var s =str(time_left / 1000)
	var ms = str(int(time_left % 1000)/10)
	var fucking_zero = '0' if len(ms) == 1 else ''
	TimeLeftValueLabel.text = s+':'+fucking_zero+ms
	DistanceValueLabel.text = str(int(Store.score/100))+'m'
