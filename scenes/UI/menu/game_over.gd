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
	$"player loose".text = "Oh no, you loose  (x_x)"
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
	
	
