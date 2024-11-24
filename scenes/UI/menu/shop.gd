extends Control

@onready var store: Store = get_node("/root/Store")

func _input(event):
	if event.is_action_pressed("Start"):
		store.level += 1
		get_tree().change_scene_to_file(store.level_to_scene[store.level])
