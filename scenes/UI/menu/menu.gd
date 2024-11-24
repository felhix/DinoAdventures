extends Node

@onready var labelPlayerA = get_node('PlayerA2')
@onready var labelPlayerB = get_node('PlayerB2')
@onready var selectionPlayerA = get_node('SelectA')
@onready var selectionPlayerB = get_node('SelectB')
@onready var STORE: Store = get_node("/root/Store")

const OFFSET_LEFT = 700
const OFFSET_TOP = 80
const MARGIN = 300

var selectedPlayerA = 0
var selectedPlayerB = 0

func _ready():	
	loadChars(STORE.ACharScenes, labelPlayerA)
	loadChars(STORE.BCharScenes, labelPlayerB)
	
	moveSelection(labelPlayerA,selectionPlayerA, selectedPlayerA)
	moveSelection(labelPlayerB,selectionPlayerB, selectedPlayerB)

func _input(event):
	if event.is_action_pressed("Start"):
		STORE.playerAIdx = selectedPlayerA
		STORE.playerBIdx = selectedPlayerB
		get_tree().change_scene_to_file(STORE.level_to_scene[STORE.level])
	
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
		
func getIndex(i, length):
	if i < 0:
		return length+i
	else:
		return i % length

func popPlayerA(i:int):
	selectedPlayerA = getIndex(selectedPlayerA+i, len(STORE.ACharScenes))
	moveSelection(labelPlayerA,selectionPlayerA, selectedPlayerA)

func popPlayerB(i:int):
	selectedPlayerB = getIndex(selectedPlayerB+i, len(STORE.BCharScenes))
	moveSelection(labelPlayerB, selectionPlayerB, selectedPlayerB)
	
func moveSelection(anchor, selection, i):
	selection.position.x = anchor.position.x+ OFFSET_LEFT + i*MARGIN
	
func addPlayer(anchor, player, index):
	anchor.add_sibling(player)
	player.idleAnim()
	
	player.scale = Vector2(5, 5)
	player.position.x = anchor.position.x + OFFSET_LEFT + index*MARGIN
	player.position.y = anchor.position.y + OFFSET_TOP

func loadChars(charsScenes, anchor): 
	for i in range(0,len(charsScenes)):
		var player = charsScenes[i].instantiate()
		addPlayer(anchor, player, i)
	
