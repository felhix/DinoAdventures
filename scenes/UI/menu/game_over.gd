extends Node

func _input(event):
	if event.is_action_pressed("Start"):
		get_tree().change_scene_to_file("res://scenes/UI/menu/menu.tscn")
