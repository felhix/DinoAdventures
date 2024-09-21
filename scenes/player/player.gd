extends CharacterBody2D
class_name Player

const SPEED = 100.0
const JUMP_VELOCITY = -1200.0
const gravity_force = 4000
signal game_over

var AorB = "A"

func jump_key():
	return 'jump_player_'+ AorB

func _ready():
	add_to_group("players")
	idleAnim()

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

func deathAnim():
	$AnimatedSprite2D.play("death")
	
func canPlay():
	return "started" in get_parent()

func _physics_process(delta: float) -> void:
	if canPlay() and get_parent().started:
		if not is_on_floor():
			velocity += get_gravity()*3.4 * delta
			runAnim()
		else: 
			if canPlay() and canJump() and Input.is_action_just_pressed(jump_key()):
				velocity.y = JUMP_VELOCITY
				jumpAnim()
			else:
				runAnim()

	move_and_slide()

func take_damage():
	emit_signal("game_over")
	Store.setLoser(self.duplicate())
