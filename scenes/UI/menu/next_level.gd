extends Control

@onready var STORE: Store = get_node("/root/Store")

func _input(event):
	if event.is_action_pressed("Start"):
		STORE.level +=1
		get_tree().change_scene_to_file(STORE.level_to_scene[STORE.level])
