class_name EntityLevel extends Node2D

@export var back_day_night_color: CanvasModulate
@export var ground_day_night_color: CanvasModulate
@export var level_time_left: int
@onready var score_ui: ScoreUI = $ScoreUi
@onready var time_left = level_time_left

var started: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Music.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(started == true):
		time_left -= delta*1000
		back_day_night_color.color = Color("#00246e").lerp(Color("#FFF"), time_left / level_time_left)
		ground_day_night_color.color = Color("#86d4ff").lerp(Color("#FFF"), time_left / level_time_left)
		score_ui.time_left = time_left

	if started == false and Input.is_action_just_pressed("ui_accept"):
		started= true
