extends Node

var started = false

func _ready():
	print(Store.loser)
	$"player died".text = "Oh no, you died  (x_x)"
	get_node('.').add_child(Store.loser)
	Store.loser.scale = Vector2(6,6)
	Store.loser.deathAnim()
	Store.loser.position.x = $empty.position.x
	Store.loser.position.y = $empty.position.y

func _input(event):
	if event.is_action_pressed("Start"):
		Store.reset()
		get_tree().change_scene_to_file("res://scenes/UI/menu/menu.tscn")
	
	
