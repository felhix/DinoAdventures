class_name EntityLevel extends Node2D

@export var BackDayNightColor: CanvasModulate
@export var GroundDayNightColor: CanvasModulate
@export var LEVEL_TIME_LEFT: int
@onready var Score: ScoreUI = $ScoreUi
@onready var time_left = LEVEL_TIME_LEFT

var started: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Music.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(started == true):
		time_left -= delta*1000
		BackDayNightColor.color = Color("#00246e").lerp(Color("#FFF"), time_left / LEVEL_TIME_LEFT)
		GroundDayNightColor.color = Color("#86d4ff").lerp(Color("#FFF"), time_left / LEVEL_TIME_LEFT)
		Score.time_left = time_left

	if started == false and Input.is_action_just_pressed("ui_accept"):
		started= true
