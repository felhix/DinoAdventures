extends Node

@onready var labelPlayerA = get_node('PlayerA2')
@onready var labelPlayerB = get_node('PlayerB2')
@onready var Store = get_node("/root/Store")

var started = false

var playerAList = []
var playerBList = []

var selectedPlayerA = 0
var selectedPlayerB = 0

func addPlayer(anchor, player, index):
	anchor.add_sibling(player)
	player.runAnim()
	
	player.scale = Vector2(5, 5)
	player.position.x = anchor.position.x + 500 + index*300
	player.position.y = anchor.position.y + 50


func _ready():	
	var ACharScenes = Store.ACharScenes
	var BCharScenes = Store.BCharScenes
	
	for i in range(0,len(ACharScenes)):
		var player = ACharScenes[i].instantiate()
		addPlayer(labelPlayerA, player, i)
		playerAList.append(player)
	
	for j in range(0,len(BCharScenes)):
		var player = BCharScenes[j].instantiate()
		addPlayer(labelPlayerB,player, j)
		playerBList.append(player)

func _input(event):
	if event.is_action_pressed("Start"):
		get_tree().change_scene_to_file("res://scenes/level/level.tscn")
	
	# select player A
	if event.is_action_pressed("next_player_A"):
		popPlayerA(1)
		
	if event.is_action_pressed("previous_player_A"):
		popPlayerA(-1)
		
	# select player B
	if event.is_action_pressed("next_player_B"):
		popPlayerB(1)
		
	if event.is_action_pressed("previous_player_B"):
		popPlayerB(-1)
		
func popPlayerA(i:int):
	selectedPlayerA = (selectedPlayerA+i) % len(Store.ACharScenes)
	updateList(playerAList, i)

func popPlayerB(i:int):
	selectedPlayerB = (selectedPlayerB+i) % len(Store.BCharScenes)
	updateList(playerBList, i)
	
func updateList(list, i):
	for u in range(0, len(list)):
		if i==u:
			list[i].add_child()
		else:
			list[i].select(false)
