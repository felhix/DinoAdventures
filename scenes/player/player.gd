extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -400.0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not get_parent().started:
		$AnimatedSprite2D.play("idle")
	else: 
		$AnimatedSprite2D.play("run")
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY



	move_and_slide()
