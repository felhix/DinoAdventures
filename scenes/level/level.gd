extends Node2D

@onready var Store = get_node("/root/Store")

const DEFAULT_ANIM = "idle"

var obstacle_scene = preload("res://scenes/objects/obstacle.tscn")

var screen_size : Vector2i
var speed : float = 13.1
var score= 0
var started = false

func show_score():
	$Ui.get_child(0).text = "SCORE: "+str(int(score/20))+', SPEED: '+str(int(speed))

func _ready():
	screen_size = get_window().size
	add_players()
	$Music.play()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		started= true
		generate_obstacle()
		_reset_timer()

	if started:
		speed += (30 - speed) * delta / 120
		score += speed
		show_score()
			
		for  i in range(0, len(Store.players)):
			Store.players[i].position.x += speed
			
		$Camera2D.position.x += speed

		check_and_shift_ground($Ground1, $Ground2)
		check_and_shift_ground($Ground2, $Ground1)

	else:
		show_score()

func generate_obstacle():
	var obs
	obs = obstacle_scene.instantiate()
	var obs_x : int = screen_size.x*randf_range(1.01,1.1) + $Camera2D.position.x
	var obs_y : int = $EnemySpawner.position.y
	obs.position = Vector2i(obs_x, obs_y)
	add_child(obs)
	
	if randf_range(0,2)>1:
		var obs2 = obstacle_scene.instantiate()
		obs2.position = Vector2i(obs_x+70, obs_y)
		add_child(obs2)

func add_players():
	for  i in range(0, len(Store.players)):
		var player = Store.players[i]
		player.scale = Vector2(5,5)
		player.position.x = 300 + i*300
		player.position.y = $Ground1.position.y - 140
		get_node('.').add_child(player)
		player.connect("game_over", Callable(self, "_on_game_over"))

func _on_timer_timeout() -> void:
	generate_obstacle()
	_reset_timer()

func _reset_timer():
	$Timer.wait_time = 8
	$Timer.start()

func check_and_shift_ground(ground_to_check, other_ground):
	var ground_width = screen_size.x * 2
	if $Camera2D.position.x - ground_to_check.position.x > ground_width:
		ground_to_check.position.x = other_ground.position.x + ground_width

func _on_game_over():
	started = false
	get_tree().change_scene_to_file("res://scenes/UI/menu/game_over.tscn")
