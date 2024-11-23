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

var playerA = null
var playerB = null
var loser = null
var health : int = 0
var score= 0.0 as float

func reset():
	playerA = null
	playerB = null
	score = 0
	health = 0
	loser = null
	
func setLoser(player):
	loser = player

func addPlayerA(char):
	playerA = char.instantiate()
	playerA.AorB = 'A'
	
func addPlayerB(char):
	playerB = char.instantiate()
	playerB.AorB = 'B'
	
