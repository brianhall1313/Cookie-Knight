extends Node2D


func _ready():
	var new = Global.wipe.instantiate()
	add_child(new)
	new.wipe_left()
	await GlobalSignalBus.transition_done
	



func _on_back_button_up():
	var new = Global.wipe.instantiate()
	add_child(new)
	new.wipe_out()
	await GlobalSignalBus.transition_done
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
