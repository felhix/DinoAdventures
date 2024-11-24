class_name PlayerFx extends Node2D

const jump_effect_scene: Resource = preload("res://scenes/objects/jump_effect.tscn")

###

func create_jump_fx(position: Vector2i) -> void:
	var jump_effect: JumpEffect = jump_effect_scene.instantiate()
	jump_effect.position = position
	add_child(jump_effect)
	jump_effect.finished.connect(jump_effect.queue_free)
