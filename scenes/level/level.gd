extends Node2D

const speed : float = 10.0
var screen_size : Vector2i

func _ready():
	screen_size = get_window().size

func _process(delta: float) -> void:
	$Player.position.x += speed
	$Camera2D.position.x += speed
	
	#update ground position
	if $Camera2D.position.x - $Ground.position.x > screen_size.x * 1.5:
		$Ground.position.x += screen_size.x
		
