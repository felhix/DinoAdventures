class_name BirdSpawner extends Node2D

const PIGEON_RESOURCE: Resource = preload("res://scenes/player/flying_player/pigeon/pigeon.tscn")
const SPEED = 50

func _ready() -> void:
	var pigeon = create_pigeon()
	add_child(pigeon)

func _process(delta: float) -> void:
	for bird in get_children():  
		if bird is FlyingPlayer:
			bird.position.x -= delta *SPEED
			bird.position.y = cos(bird.position.x) 
		# bird.transform.x += 1  # cos(delta)

### 

func create_pigeon() -> Pigeon:
	var pigeon: Pigeon = PIGEON_RESOURCE.instantiate()
	return pigeon
