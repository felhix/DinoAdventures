class_name Pigeon extends FlyingPlayer

const MIN_SPEED = 500

func _process(delta: float) -> void:
	position.x -= delta * MIN_SPEED * scale.x
	position.y += randi_range(-2, 1) + cos(position.x)
