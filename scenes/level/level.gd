extends Node2D

var speed : float = 3.0
var screen_size : Vector2i
var started = false


func _ready():
	screen_size = get_window().size

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		started= true

	if started:
		speed+= 1/log($Player.position.x) * delta
		print(speed)
		$Player.position.x += speed
		$Camera2D.position.x += speed
	
		#update ground position
		if $Camera2D.position.x - $Ground.position.x > screen_size.x * 1.5:
			$Ground.position.x += screen_size.x
		
