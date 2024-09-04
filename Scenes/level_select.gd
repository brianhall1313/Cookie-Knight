extends Node2D

func _ready():
	var new = Global.wipe.instantiate()
	add_child(new)
	new.wipe_left()


func to_adventure(level):
	Global.next_level = level
	var new = Global.wipe.instantiate()
	add_child(new)
	new.wipe_out()
	await GlobalSignalBus.transition_done
	Global.load_level()
	


func _on_level_1_button_up():
	to_adventure(1)
	
	
func _on_level_2_button_up():
	to_adventure(2)
	

func _on_level_3_button_up():
	to_adventure(3)
	



func _on_back_button_up():
	var new = Global.wipe.instantiate()
	add_child(new)
	new.wipe_out()
	await GlobalSignalBus.transition_done
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_level_4_button_up():
	to_adventure(4)


func _on_level_5_button_up():
	to_adventure(5)


func _on_level_6_button_up():
	to_adventure(6)
