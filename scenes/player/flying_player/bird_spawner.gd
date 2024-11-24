class_name BirdSpawner extends Node2D

const PIGEON_RESOURCE: Resource = preload("res://scenes/player/flying_player/pigeon/pigeon.tscn")


func _ready() -> void:
	var pigeon = create_pigeon()
	add_child(pigeon)


func _process(delta: float) -> void:
	if randi_range(0, 100) == 0:
		add_child(create_pigeon())

	for bird in get_children():  
		if bird is FlyingPlayer:
			if bird.position.x + position.x < 0:
				bird.call_deferred("queue_free")

### 

func create_pigeon() -> Pigeon:
	var pigeon: Pigeon = PIGEON_RESOURCE.instantiate()
	var depth = randf_range(1, 2.5)
	pigeon.scale *= depth
	return pigeon
