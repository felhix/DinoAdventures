extends CharacterBody2D
class_name Player

const SPEED = 100.0
const JUMP_VELOCITY = -1000.0
const gravity_force = 4000

func canJump() -> bool:
	return false
	
func canFly() -> bool:
	return false

func idleAnim():
	$AnimatedSprite2D.play("idle")
	
func runAnim():
	$AnimatedSprite2D.play("run")
	
func jumpAnim():
	$AnimatedSprite2D.play("jump")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not get_parent().started:
		idleAnim()
	else: 
		if not is_on_floor():
			velocity += get_gravity()*3.4 * delta
		else: 
			if canJump() and Input.is_action_just_pressed("ui_accept"):
				velocity.y = JUMP_VELOCITY
				jumpAnim()
			else:
				runAnim()

	move_and_slide()
