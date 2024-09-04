extends Node2D

@onready var cookie=preload("res://Scenes/falling_cookie.tscn")
@onready var cookie_spawn = $cookie_spawn_path/cookie_spawn

@onready var cookie_spawn_path = $cookie_spawn_path

var in_credits:bool = false
var in_how_to_play:bool = false


func _ready():
	$"Control/VBoxContainer/VBoxContainer/New Game".grab_focus()
	var new = Global.wipe.instantiate()
	add_child(new)
	new.wipe_in()

func _process(_delta):
	if Input.is_action_just_pressed("esc"):
		if in_credits:
			_on_credits_back_button_up()
		if in_how_to_play:
			_on_how_to_play_button_back_button_up()
		else:
			_on_quit_button_up()


func transition():
	var new = Global.wipe.instantiate()
	add_child(new)
	new.wipe_right()

func popup_transition_one():
	var new = Global.wipe.instantiate()
	add_child(new)
	new.wipe_right()

func popup_transition_two():
	var new = Global.wipe.instantiate()
	add_child(new)
	new.wipe_left()


func _on_quit_button_up():
	var new = Global.wipe.instantiate()
	add_child(new)
	new.wipe_right()
	await GlobalSignalBus.transition_done
	get_tree().quit()


func _on_new_game_button_up():
	transition()
	await GlobalSignalBus.transition_done
	get_tree().change_scene_to_file("res://Scenes/level_select.tscn")


func _on_credits_button_up():
	popup_transition_one()
	await GlobalSignalBus.transition_done
	$Control/credits.show()
	in_credits = true
	popup_transition_two()
	await GlobalSignalBus.transition_done
	$Control/VBoxContainer/VBoxContainer/Credits.release_focus()
#	$Control/credits/VBoxContainer/credits_back.grab_focus()

func _on_how_to_play_button_up():
	popup_transition_one()
	await GlobalSignalBus.transition_done
	$"Control/how to play".show()
	in_how_to_play = true
	popup_transition_two()
	await GlobalSignalBus.transition_done
	$"Control/VBoxContainer/VBoxContainer/How to Play".release_focus()
#	$"Control/how to play/VBoxContainer/how_to_play_button_back".grab_focus()


func _on_how_to_play_button_back_button_up():
	popup_transition_one()
	await GlobalSignalBus.transition_done
	$"Control/how to play".hide()
	in_how_to_play = false
	popup_transition_two()
	await GlobalSignalBus.transition_done
	$"Control/VBoxContainer/VBoxContainer/New Game".grab_focus()


func _on_credits_back_button_up():
	popup_transition_one()
	await GlobalSignalBus.transition_done
	$Control/credits.hide()
	in_credits = false
	popup_transition_two()
	await GlobalSignalBus.transition_done
	$"Control/VBoxContainer/VBoxContainer/New Game".grab_focus()


func _on_continue_button_up():
	transition()
	await GlobalSignalBus.transition_done
	Global.load_stuff()
	get_tree().change_scene_to_file("res://level_select.tscn")


func _on_cookie_timer_timeout():
	var new = cookie.instantiate()
	cookie_spawn.progress_ratio = randf()
	new.position = cookie_spawn.position
	$cookie_container.add_child(new)
