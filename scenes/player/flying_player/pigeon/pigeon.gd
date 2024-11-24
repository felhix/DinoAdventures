class_name Pigeon extends FlyingPlayer

const MIN_SPEED = 500

func _process(delta: float) -> void:
	position.x -= delta * MIN_SPEED * scale.x
	position.y = cos(position.x) 
