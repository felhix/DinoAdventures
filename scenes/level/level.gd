extends Node2D

var obstacle_scene = preload("res://scenes/objects/obstacle.tscn")

var screen_size : Vector2i
var ground_height : int
var speed : float = 3.0
var started = false
var score= 0

func show_score():
	$Ui.get_child(0).text = "SCORE: "+str(int(score/20))

func _ready():
	screen_size = get_window().size
	ground_height = $Ground.get_node("Sprite2D").texture.get_height()

func _process(delta: float) -> void:
	$Player.position.x += speed
	$Camera2D.position.x += speed

	if Input.is_action_just_pressed("ui_accept"):
		started= true

	if started:
		speed+= 1/log($Player.position.x) * delta

		score += speed
		show_score()

		print(speed)
		$Player.position.x += speed
		$Camera2D.position.x += speed

		#update ground position
		if $Camera2D.position.x - $Ground.position.x > screen_size.x * 1.5:
			$Ground.position.x += screen_size.x
	else:
		show_score()

func generate_obstacle():
		var obs
		obs = obstacle_scene.instantiate()
		var obs_x : int = screen_size.x + $Player.position.x + 100
		var obs_y : int = 0
		add_obs(obs, obs_x, obs_y)

func add_obs(obs, x, y):
	obs.position = Vector2i(x, y)
	add_child(obs)


func _on_timer_timeout() -> void:
	#generate obstacles
	generate_obstacle()
