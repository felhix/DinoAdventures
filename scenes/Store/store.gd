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
	preload("res://scenes/player/flying_player/pigeon/pigeon.tscn")
]

var players = []

var jumpPlayerA = "jump_player_A"
var jumpPlayerB = "jump_player_B"

func addPlayerA(char):
	players.append(char.instantiate())
	
func addPlayerB(char):
	players.append(char.instantiate())
