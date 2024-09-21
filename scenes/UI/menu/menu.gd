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

func addPlayer(anchor, player, index):
	var char = player.instantiate()
	anchor.add_sibling(char)
	char.runAnim()
	
	char.scale = Vector2(5, 5)
	char.position.x = anchor.position.x + 500 + index*300
	char.position.y = anchor.position.y + 50

var started = false

func _ready():
	var labelPlayerA = get_node('PlayerA2')
	var labelPlayerB = get_node('PlayerB2')
	
	for i in range(0,len(ACharScenes)):
		addPlayer(labelPlayerA,ACharScenes[i], i)
	
	for j in range(0,len(BCharScenes)):
		addPlayer(labelPlayerB,BCharScenes[j], j)

func _input(event):
	if event.is_action_pressed("Start"):
		get_tree().change_scene_to_file("res://scenes/level/level.tscn")
