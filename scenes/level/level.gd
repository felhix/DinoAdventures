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
	initialize_scene()
	$Music.play()
		
	Store.health = 1

func _process(delta: float) -> void:	
	var frame_speed = MASTER_SPEED * delta
	if started == false and Input.is_action_just_pressed("ui_accept"):
		started= true
		_reset_timer()

	if started:
		Store.score += frame_speed/1000.0*pow(multiplier(), 3)
		show_score()
			
	
		Store.playerA.position.x += frame_speed * Store.playerA.speed_multiplier
		Store.playerB.position.x += frame_speed * Store.playerB.speed_multiplier
		var min_pos = min(Store.playerA.position.x,Store.playerB.position.x) 
		
		$Camera2D.position.x = min_pos - 200
		$FinishLine.position.x = min_pos + get_viewport().size.x - 350

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
	

func initialize_scene():
	var players = [Store.playerA, Store.playerB]
	for  i in range(0, 2):
		var player: Player  = players[i]
		player.scale = Vector2(5,5)
		player.position.x = 200 + i*70
		player.position.y = $Ground1.position.y - 140
		get_node('.').add_child(player)
	
		player.game_over.connect(_on_game_over)
		player.jump.connect(_on_jump)

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
	var jump_effect: JumpEffect = jump_effect_scene.instantiate()
	jump_effect.position = position
	add_child(jump_effect)
	jump_effect.finished.connect(jump_effect.queue_free)
	
