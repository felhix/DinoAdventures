class_name Level extends Node2D

@onready var STORE: Store = get_node("/root/Store")
@onready var BackDayNightColor: CanvasModulate = $Background/BackDayNightColor
@onready var BackDayNightColorGround: CanvasModulate = $Ground1/BackDayNightColor2
@onready var FinishFlag = $FinishLine
@onready var Score: ScoreUI = $Ui
@onready var player_fx: PlayerFx = $PlayerFx

const DEFAULT_ANIM = "idle"
const MASTER_SPEED = 1400
const MIN_OBSTACLE_X_DISTANCE = 150
const LEVEL_TIME_LEFT = 35_000

const obstacle_scene: Resource = preload("res://scenes/objects/obstacle.tscn")

var screen_size : Vector2i
var started = false
var time_left = 0

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

	if started:
		Score.time_left = time_left
		STORE.playerA.position.x += frame_speed * STORE.playerA.get_speed_multiplier()
		STORE.playerB.position.x += frame_speed * STORE.playerB.get_speed_multiplier()
		set_camera_position(STORE.playerA.position.x,STORE.playerB.position.x)
		STORE.set_score()

	else:
		Score.time_left = time_left

func set_camera_position(x1, x2):
	$Camera2D.position.x =  (x1+x2)/2  - get_viewport().size.x/2 +100

func multiplier():
	return len(str(int(STORE.score)))

func spawn_all_ennemies():
	spawn_recursive($Camera2D.position.x + 200+int(100*randf()))
	
func spawn_recursive(x):
	var end = FinishFlag.position.x
	
	if(x > end):
		return
	
	add_ennemy(x)
	
	var additionnal_ennemies_count =  int((3*x+end)/end)
	for i in randi_range(0,additionnal_ennemies_count):
		add_ennemy(x+i*150+100*randf())

	var next_x = x+ (2.5 * end /(x+end) * 900) + 200*randf_range(0.5,1.0)*randi_range(-1.0,1.0)
	spawn_recursive(next_x)
	

func add_ennemy(x):	
	var obs = obstacle_scene.instantiate()
	add_child(obs)
	obs.scale = obs.scale * randf_range(1, 1.25)
	var obs_x : int = x + screen_size.x + $Camera2D.position.x + (obs.width * obs.scale.x) * 2
	var obs_y : int = $EnemySpawner.position.y
	obs.position = Vector2i(obs_x, obs_y)

func initialize_scene():
	STORE.addPlayerA(STORE.playerAIdx)
	STORE.addPlayerB(STORE.playerBIdx)
	var players = [STORE.playerA, STORE.playerB]
	for  i in range(0, 2):
		var player: Player  = players[i]
		if player == null: continue
		player.scale = Vector2(5,5)
		player.position.x = get_viewport().size.x/2 +200 + i*70
		player.position.y = $Ground1.position.y - 140
		get_node('.').add_child(player)
	
		player.game_won.connect(_on_game_won)
		player.jump.connect(_on_jump)
		
	set_camera_position(Store.playerA.position.x, Store.playerB.position.x)
	spawn_all_ennemies()

func _on_game_over():
	started = false
	get_tree().change_scene_to_file("res://scenes/UI/menu/game_over.tscn")

func _on_game_won():
	started = false
	
	if STORE.level < len(Store.level_to_scene) - 1:
		get_tree().change_scene_to_file("res://scenes/UI/menu/shop.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/UI/menu/game_won.tscn")


func _on_jump(position: Vector2): 
	player_fx.create_jump_fx(position)
