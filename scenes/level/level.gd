class_name Level extends Node2D

@onready var Store = get_node("/root/Store")

const DEFAULT_ANIM = "idle"
const CHANGE_OBSTACLE = 3
const MASTER_SPEED = 1400
const MIN_OBSTACLE_X_DISTANCE = 150
const SCALE_ON_SCORE_DIVISER = 1_000
const DISTANCE_ON_SCORE_DIVISER = 1_000

const obstacle_scene: Resource = preload("res://scenes/objects/obstacle.tscn")
const jump_effect_scene: Resource = preload("res://scenes/objects/jump_effect.tscn")

var screen_size : Vector2i
var started = false

func show_score():
	$Ui.get_child(0).text = "SCORE: "+str(int(Store.score))

func _ready():
	screen_size = get_window().size
	add_players()
	$Music.play()
	
	$WinningEffect_tscn.scale = Vector2(5,5)
	$WinningEffect_tscn.position.y = get_viewport().size.y*0.9
	$WinningEffect_tscn.position.x = get_viewport().size.x
	Store.health = 1

func _process(delta: float) -> void:	
	var frame_speed = MASTER_SPEED * delta
	if started == false and Input.is_action_just_pressed("ui_accept"):
		started= true
		_reset_timer()

	if started:
		Store.score += frame_speed/1000.0*pow(multiplier(), 3)
		show_score()
			
		var min_speed = min(Store.playerA.speed_multiplier,Store.playerB.speed_multiplier) 
	
		Store.playerA.position.x += frame_speed * Store.playerA.speed_multiplier			
		Store.playerB.position.x += frame_speed * Store.playerA.speed_multiplier			
			
		$Camera2D.position.x += min_speed * frame_speed
		$WinningEffect_tscn.position.x += min_speed * frame_speed
		$FinishLine.position.x += min_speed * frame_speed

		check_and_shift_ground($Ground1, $Ground2)
		check_and_shift_ground($Ground2, $Ground1)
 
	else:
		show_score()
		
func multiplier():
	return len(str(int(Store.score)))

func generate_obstacle(score: int, delta_x = 0):
	var obs = obstacle_scene.instantiate()
	add_child(obs)
	
	obs.scale = obs.scale * randf_range(1, 1.25)
	
	var obs_x : int = delta_x + screen_size.x + $Camera2D.position.x + (obs.width * obs.scale.x) * 2
	var obs_y : int = $EnemySpawner.position.y
	obs.position = Vector2i(obs_x, obs_y)
	
	if randi_range(0, CHANGE_OBSTACLE)==0:
		generate_obstacle(score, delta_x + MIN_OBSTACLE_X_DISTANCE)
	

func add_players():
	var players = [Store.playerA, Store.playerB]
	for  i in range(0, 2):
		var player: Player  = players[i]
		player.scale = Vector2(5,5)
		player.position.x = 300 + i*300
		player.position.y = $Ground1.position.y - 140
		get_node('.').add_child(player)
<<<<<<< HEAD
	
	Store.playerA.connect("game_over", Callable(Store.playerB, "_on_game_over"))
	Store.playerB.connect("game_over", Callable(Store.playerA, "_on_game_over"))
=======
		player.game_over.connect(_on_game_over)
		player.jump.connect(_on_jump)
>>>>>>> c5906a618fbc06f6f90d483c41ab54c1f5ab2f50

func _on_timer_timeout() -> void:
	generate_obstacle(Store.score)
	_reset_timer()

func _reset_timer():
	$Timer.stop()
	$Timer.wait_time = 1.3*(10.0/(multiplier()*2.0+10.0))*randf_range(1.01,1.1)
	$Timer.start()

func check_and_shift_ground(ground_to_check, other_ground):
	var ground_width = screen_size.x * 2
	if $Camera2D.position.x - ground_to_check.position.x > ground_width:
		ground_to_check.position.x = other_ground.position.x + ground_width

func _on_game_over():
	started = false
	get_tree().change_scene_to_file("res://scenes/UI/menu/game_over.tscn")

func _on_jump(position: Vector2): 
	var jump_effect = jump_effect_scene.instantiate()
	jump_effect.position = position
	
	add_child(jump_effect)
	
