extends Node

# this is the global store

const ACharScenes = [
	preload("res://scenes/player/ground_player/bear/bear.tscn"),
	preload("res://scenes/player/ground_player/fox/fox.tscn"),
	preload("res://scenes/player/ground_player/adult_deer/adult_deer.tscn"),
]
const BCharScenes = [
	preload("res://scenes/player/ground_player/wolf/wolf.tscn"),
	preload("res://scenes/player/ground_player/boar/boar.tscn"),
	preload("res://scenes/player/ground_player/bunny/bunny.tscn")
]

var players = []

func reset():
	players = []
	

func addPlayerA(char):
	addPlayer(char,  "jump_player_A")
	
func addPlayerB(char):
	addPlayer(char,  "jump_player_B")

func addPlayer(char, key):
	var d = char.instantiate()
	d.jump_key = key
	players.append(d)
	
