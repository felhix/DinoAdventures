class_name EntityLevel extends Node2D

@export var back_day_night_color: CanvasModulate
@export var ground_day_night_color: CanvasModulate
@export var level_time_left: int
@onready var player_fx: PlayerFx = $PlayerFx

@onready var store: Store = get_node("/root/Store")
@onready var score_ui: ScoreUI = $ScoreUi
@onready var time_left = level_time_left

var started: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Music.play()
	initialize_scene()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(started == true):
		time_left -= delta*1000
		back_day_night_color.color = Color("#00246e").lerp(Color("#FFF"), time_left / level_time_left)
		ground_day_night_color.color = Color("#86d4ff").lerp(Color("#FFF"), time_left / level_time_left)
		score_ui.time_left = time_left

	if started == false and Input.is_action_just_pressed("ui_accept"):
		started= true
		
	if time_left < 0:
		call_deferred("_on_game_over")

###

func _on_game_over():
	started = false
	get_tree().change_scene_to_file("res://scenes/UI/menu/game_over.tscn")

func _on_game_won():
	started = false
	
	if store.level < len(store.level_to_scene) - 1:
		get_tree().change_scene_to_file("res://scenes/UI/menu/shop.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/UI/menu/game_won.tscn")

###

func _on_jump(position: Vector2):
	player_fx.create_jump_fx(position)

###

func initialize_scene():
	store.addPlayerA(store.playerAIdx)
	store.addPlayerB(store.playerBIdx)
	var players = [store.playerA, store.playerB]
	for  i in range(0, 2):
		var player: Player  = players[i]
		if player == null: continue
		player.scale = Vector2(5,5)
		player.position.x = 200 + i*70
		player.position.y = $Ground.position.y
		add_child(player)
	
		player.game_won.connect(_on_game_won)
		player.jump.connect(_on_jump)
		
	# set_camera_position(Store.playerA.position.x, Store.playerB.position.x)
