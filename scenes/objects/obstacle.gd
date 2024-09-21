extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("obstacles")

func _on_body_entered(body):
	if body.is_in_group("players"):
		body.take_damage()
  
