extends Node


const ACharScenes = [
	preload("res://scenes/player/ground_player/bear/bear.tscn"),
	preload("res://scenes/player/ground_player/fox/fox.tscn"),
	preload("res://scenes/player/ground_player/adult_deer/adult_deer.tscn"),
]
const BCharScenes = [
	preload("res://scenes/player/flying_player/bird/bird.tscn"),
	preload("res://scenes/player/flying_player/pigeon/pigeon.tscn")
]


var started = false

func _ready():
	var containerA = get_node('.')
	
	print(ACharScenes)
	
	
	for i in range(0,len(ACharScenes)):
		var char = ACharScenes[i].instantiate()
		char.runAnim()
		containerA.add_child(char)
		char.position.x = containerA.position.x
		char.position.y = containerA.position.y
		
		print(char)

func _input(event):
	if event.is_action_pressed("Start"):
		get_tree().change_scene_to_file("res://scenes/level/level.tscn")
