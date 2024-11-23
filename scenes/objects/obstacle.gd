class_name Obstacle extends Area2D

@onready var MiniThief: AnimatedSprite2D = $AnimatedSprite2D
@onready var MiniMiner: AnimatedSprite2D = $AnimatedSprite2D2
@onready var MiniHunter: AnimatedSprite2D = $AnimatedSprite2D3
@onready var CollisingShape: CollisionShape2D = $CollisionShape2D

@export var width: int:
	get:
		return CollisingShape.shape.radius * 2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	select_random_sprite_to_be_visible([
		MiniThief,
		MiniMiner,
		MiniHunter
	])
	add_to_group("obstacles")

func _on_body_entered(body):
	if body.is_in_group("players"):
		body.take_damage()

func select_random_sprite_to_be_visible(array_of_sprites):
	var random_index = randi() % array_of_sprites.size()
	# Loop through all array_of_sprites, show the randomly selected one, and hide the others
	for i in range(array_of_sprites.size()):
		if i == random_index:
			array_of_sprites[i].visible = true  # Show the selected sprite
		else:
			array_of_sprites[i].visible = false  # Hide the others
