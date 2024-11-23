class_name JumpEffect extends Node2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

@export var finished: Signal:
	get:
		return sprite.animation_finished
