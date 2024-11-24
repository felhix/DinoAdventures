extends Node

const CAPTIONS = [
	"You are so slow",
	"Try harder next time.",
	"Nice try, little friend.",
	"Good one.",
	"Ok, you rock."
]

func caption():
	return CAPTIONS[randi_range(0,len(CAPTIONS)-1 )]

func _ready():
	$"player died".text = "Oh no, you loose  (x_x)"
	$score.text = str(int(Store.score))+ "m. "+caption()
	
	var players = [Store.instantiatePlayerA(), Store.instantiatePlayerB()]
	for  i in range(0, 2):
		var player: Player  = players[i]
		get_node('.').add_child(player)
		
		player.scale = Vector2(7,7)
		player.velocity.x = 0
		player.velocity.y = 0
		player.position.x = $empty.position.x + i * 400 - 200
		player.position.y = $empty.position.y
		
		player.deathAnim()

func _input(event):
	if event.is_action_pressed("Start"):
		Store.reset()
		get_tree().change_scene_to_file("res://scenes/UI/menu/menu.tscn")
	
	
