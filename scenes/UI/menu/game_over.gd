extends Node

const CAPTIONS = [
	"I guess that's not bad.",
	"You can do it.",
	"Nice try, you little fox.",
	"Good one.",
	"Ok, you rock."
]

func caption():
	return CAPTIONS[randi_range(0,len(CAPTIONS))]

func _ready():
	$"player died".text = "Oh no, you died  (x_x)"
	$score.text = str(int(Store.score))+ " points. "+caption()
	get_node('.').add_child(Store.loser)
	Store.loser.deathAnim()
	Store.loser.scale = Vector2(7,7)
	Store.loser.position.x = $empty.position.x
	Store.loser.position.y = $empty.position.y

func _input(event):
	if event.is_action_pressed("Start"):
		Store.reset()
		get_tree().change_scene_to_file("res://scenes/UI/menu/menu.tscn")
	
	
