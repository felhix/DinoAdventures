class_name BirdSpawner extends Node2D

@onready var Store: Store = get_node("/root/Store")

const PIGEON_RESOURCE: Resource = preload("res://scenes/player/flying_player/pigeon/pigeon.tscn")

func _process(delta: float) -> void:
	if Store.score <= 1:
		return

	if randi_range(0, 1_000) < 5:
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
