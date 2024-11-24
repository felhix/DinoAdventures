extends Node

# this is the global store

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

func reset():
	playerA = null
	playerB = null
	
func set_score():
	score= min(playerA.position.x, playerB.position.x)
	
func instantiatePlayerA():
	return ACharScenes[playerAIdx].instantiate()
func instantiatePlayerB():
	return ACharScenes[playerBIdx].instantiate()

func addPlayerA(idx):
	playerAIdx = idx
	playerA = instantiatePlayerA()
	playerA.AorB = 'A'
	
func addPlayerB(idx):
	playerBIdx = idx
	playerB = instantiatePlayerB()
	playerB.AorB = 'B'
	
