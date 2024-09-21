extends CharacterBody2D
class_name Player

const SPEED = 100.0
const JUMP_VELOCITY = -1000.0
const gravity_force = 4000

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not get_parent().started:
		$AnimatedSprite2D.play("idle")
	else: 
		if not is_on_floor():
			velocity += get_gravity()*3.4 * delta
		else: 
			if Input.is_action_just_pressed("ui_accept"):
				velocity.y = JUMP_VELOCITY
				$AnimatedSprite2D.play("jump")
			else:
				$AnimatedSprite2D.play("run")

	move_and_slide()
