extends Area2D

var sprites: Array = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprites.append($AnimatedSprite2D2)
	sprites.append($AnimatedSprite2D)
	sprites.append($AnimatedSprite2D3)
	select_random_sprite_to_be_visible(sprites)
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
