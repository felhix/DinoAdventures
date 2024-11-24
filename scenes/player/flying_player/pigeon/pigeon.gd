class_name Pigeon extends FlyingPlayer

const MIN_SPEED = 500

func _on_body_entered(body):
	if body.is_in_group("players"):
		body.take_damage()
		
func _process(delta: float) -> void:
	position.x -= delta * MIN_SPEED * scale.x
	position.y += randi_range(-2, 2) + cos(position.x)
