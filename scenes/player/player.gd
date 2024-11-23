class_name Player extends CharacterBody2D

const JUMP_VELOCITY = -3000.0
signal game_over()
signal jump(position: Vector2)

var AorB = "A"
var is_blinking : bool = false
var is_invicible : bool = false
var speed_multiplier : float = 1.0

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

func _process(delta: float) -> void:
	if is_blinking == true:
		$AnimatedSprite2D.set_visible(randi_range(0,1))
	
func _physics_process(delta: float) -> void:
	if Input.is_action_just_released(jump_key()):
		if (velocity.y > JUMP_VELOCITY):
			velocity.y /= 2
			
	if canPlay() and get_parent().started:
		if not is_on_floor():
			velocity += get_gravity()*10 * delta
			jumpAnim()
		else: 
			if canPlay() and canJump() and Input.is_action_just_pressed(jump_key()):
				velocity.y = JUMP_VELOCITY
				jump.emit(self.position)
				jumpAnim()
			else:
				runAnim()

	move_and_slide()

func take_damage():
	set_timer(true)

func set_timer(slow_down):
	$Timer.start()
	is_invicible = true
	is_blinking = true
	speed_multiplier = 0.85 if slow_down else 1.1
	

func _on_timer_timeout() -> void:
	is_invicible = false
	is_blinking = false
	$AnimatedSprite2D.set_visible(true)
	speed_multiplier = 1
	

func enter_finish_line():
	emit_signal("game_over")
	Store.setLoser(self.duplicate())
