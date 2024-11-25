extends Node

# this is the global store

const SAVE_PATH = "user://highscore.bin"


const ACharScenes = [
	preload("res://scenes/player/ground_player/bear/bear.tscn"),
	preload("res://scenes/player/ground_player/adult_deer/adult_deer.tscn"),
	preload("res://scenes/player/ground_player/fox/fox.tscn"),
]
const BCharScenes = [
	preload("res://scenes/player/ground_player/boar/boar.tscn"),
	preload("res://scenes/player/ground_player/wolf/wolf.tscn"),
	preload("res://scenes/player/ground_player/bunny/bunny.tscn")
]

var playerA: Player = null
var playerAIdx = 0
var playerB: Player = null
var playerBIdx = 0
var score = 0;
var money : int = 0 
var level: int = 0;

var high_score = -1

const level_to_scene = [
	"res://scenes/level/level.tscn",
	"res://scenes/level/city_dirty.tscn"
]

func _ready():
	high_score = load_highscore()
	print(high_score)
	

func reset():
	playerA = null
	playerB = null
	level = 0
	score=0
	
func set_score():
	score= min(playerA.position.x, playerB.position.x)
	
func instantiatePlayerA():
	return ACharScenes[playerAIdx].instantiate()

func instantiatePlayerB():
	return BCharScenes[playerBIdx].instantiate()

func addPlayerA(idx):
	playerAIdx = idx
	playerA = instantiatePlayerA()
	playerA.AorB = 'A'
	
func addPlayerB(idx):
	playerBIdx = idx
	playerB = instantiatePlayerB()
	playerB.AorB = 'B'
	

func save_highscore(highscore: int) -> void:
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_64(highscore)
	else:
		push_warning("Couldn't save highscore file: ", error_string(FileAccess.get_open_error()))

func load_highscore() -> int:
	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file:
		return file.get_64()
	else:
		push_warning("Couldn't load highscore file: ", error_string(FileAccess.get_open_error()))
		return -1
