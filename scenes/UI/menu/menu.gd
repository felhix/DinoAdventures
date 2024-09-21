extends Node


const ACharScenes = [
	"res://scenes/player/ground_player/bear/bear.tscn",
	"res://scenes/player/ground_player/fox/fox.tscn",
	"res://scenes/player/ground_player/adult_deer/adult_deer.tscn",
]
const BCharScenes = [
	"res://scenes/player/flying_player/bird/bird.tscn",
	"res://scenes/player/flying_player/pigeon/pigeon.tscn"
]

func _ready():
	var containerA = get_node('ContainerPlayerA')
	
	print(ACharScenes)
	
	
	for i in range(0,len(ACharScenes)):
		var char = load(ACharScenes[i])
		containerA.add_child(char)
		char.position.x = containerA.position.x
		char.position.y = containerA.position.y
		
		print(char)

func _input(event):
	if event.is_action_pressed("jump"):
		get_tree().change_scene("res://scenes/level/level.tscn")
