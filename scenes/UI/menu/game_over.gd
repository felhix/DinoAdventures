extends Node

const CAPTIONS = [
	"You are so slow",
	"Try harder next time.",
	"Nice try, you little friend.",
	"Good one.",
	"Ok, you rock."
]

func caption():
	return CAPTIONS[randi_range(0,len(CAPTIONS)-1 )]

func _ready():
	$"player died".text = "Oh no, you loose  (x_x)"
	$score.text = str(int(Store.score))+ " points. "+caption()
	
	var players = [Store.instatiatePlayerA(), Store.instatiatePlayerB()]
	for  i in range(0, 2):
		var player: Player  = players[i]
		
		if player == null: continue
		
		get_node('.').add_child(player.duplicate())
		
		player.deathAnim()
		player.scale = Vector2(7,7)
		player.position.x = $empty.position.x + i * 200 - 400
		player.position.y = $empty.position.y

func _input(event):
	if event.is_action_pressed("Start"):
		Store.reset()
		get_tree().change_scene_to_file("res://scenes/UI/menu/menu.tscn")
	
	
