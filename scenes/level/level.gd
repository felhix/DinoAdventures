class_name Level extends Node2D

@onready var STORE: Store = get_node("/root/Store")
@onready var BackDayNightColor: CanvasModulate = $Background/BackDayNightColor
@onready var BackDayNightColorGround: CanvasModulate = $Ground1/BackDayNightColor2

const DEFAULT_ANIM = "idle"
const CHANGE_OBSTACLE = 3
const MASTER_SPEED = 1400
const MIN_OBSTACLE_X_DISTANCE = 150
const LEVEL_TIME_LEFT = 35_000

const obstacle_scene: Resource = preload("res://scenes/objects/obstacle.tscn")
const jump_effect_scene: Resource = preload("res://scenes/objects/jump_effect.tscn")

var screen_size : Vector2i
var started = false
var time_left = 0

func show_score():
	var time_str = int(time_left) / 1000
	var s =str(int(time_left) / 1000)
	var ms = str(int(int(time_left) % 1000)/10)
	var fucking_zero = '0' if len(ms) == 1 else ''
	$Ui.get_child(3).text = s+':'+fucking_zero+ms

func _ready():
	screen_size = get_window().size
	initialize_scene()
	$Music.play()
	time_left = LEVEL_TIME_LEFT
	
func _process(delta: float) -> void:
	if(started == true):
		time_left -=delta*1000
		BackDayNightColor.color = Color("#00246e").lerp(Color("#FFF"), time_left / LEVEL_TIME_LEFT)
		BackDayNightColorGround.color = Color("#86d4ff").lerp(Color("#FFF"), time_left / LEVEL_TIME_LEFT)

	if time_left < 0:
		call_deferred("_on_game_over")
	
	var frame_speed = MASTER_SPEED * delta
	if started == false and Input.is_action_just_pressed("ui_accept"):
		started= true
		_reset_timer()

	if started:
		show_score()
		STORE.playerA.position.x += frame_speed * STORE.playerA.get_speed_multiplier()
		STORE.playerB.position.x += frame_speed * STORE.playerB.get_speed_multiplier()
		set_camera_position(STORE.playerA.position.x,STORE.playerB.position.x)
		STORE.set_score()

	else:
		show_score()

func set_camera_position(x1, x2):
	var min_pos = min(x1,x2) 
	var max_pos = max(x2,x2) 
	
	$Camera2D.position.x = min_pos - (max_pos-min_pos)/2 - 200

func multiplier():
	return len(str(int(STORE.score)))

func generate_obstacle(score: int, delta_x = 0):
	var obs = obstacle_scene.instantiate()
	add_child(obs)
	
	obs.scale = obs.scale * randf_range(1, 1.25)
	
	var obs_x : int = delta_x + screen_size.x + $Camera2D.position.x + (obs.width * obs.scale.x) * 2
	var obs_y : int = $EnemySpawner.position.y
	obs.position = Vector2i(obs_x, obs_y)
	
	if randi_range(0, CHANGE_OBSTACLE)==0:
		generate_obstacle(score, delta_x + MIN_OBSTACLE_X_DISTANCE)

func initialize_scene():
	STORE.addPlayerA(STORE.playerAIdx)
	STORE.addPlayerB(STORE.playerBIdx)
	var players = [STORE.playerA, STORE.playerB]
	for  i in range(0, 2):
		var player: Player  = players[i]
		if player == null: continue
		player.scale = Vector2(5,5)
		player.position.x = 200 + i*70
		player.position.y = $Ground1.position.y - 140
		get_node('.').add_child(player)
	
		player.game_won.connect(_on_game_won)
		player.jump.connect(_on_jump)
		
	set_camera_position(Store.playerA.position.x, Store.playerB.position.x)

func _on_timer_timeout() -> void:
	generate_obstacle(STORE.score)
	_reset_timer()

func _reset_timer():
	$Timer.stop()
	$Timer.wait_time = 1.3*(10.0/(multiplier()*2.0+10.0))*randf_range(1.01,1.1)
	$Timer.start()

func _on_game_over():
	started = false
	get_tree().change_scene_to_file("res://scenes/UI/menu/game_over.tscn")

func _on_game_won():
	started = false
	
	if STORE.level < len(Store.level_to_scene) - 1:
		get_tree().change_scene_to_file("res://scenes/UI/menu/next_level.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/UI/menu/game_won.tscn")


func _on_jump(position: Vector2): 
	var jump_effect: JumpEffect = jump_effect_scene.instantiate()
	jump_effect.position = position
	add_child(jump_effect)
	jump_effect.finished.connect(jump_effect.queue_free)
	
