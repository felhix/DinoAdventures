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
var loser = null

func reset():
	players = []
	
func setLoser(player):
	loser = player

func addPlayer(char, AorB):
	var d = char.instantiate()
	d.AorB = AorB
	players.append(d)
	
