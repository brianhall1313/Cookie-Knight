extends Node

@onready var wipe = preload("res://Scenes/wipe.tscn")
@onready var cookie = preload("res://Scenes/cookie.tscn")
@onready var quickening = preload("res://Resources/quickening.tscn")
@onready var bloodsplosion = preload("res://Resources/dood_explosion.tscn")

var next_level = 1

var level_list:Array = [
	"res://Scenes/level.tscn",
	"res://Scenes/level_1.tscn",
	"res://Scenes/level_2.tscn",
	"res://Scenes/level_3.tscn",
	"res://Scenes/level_4.tscn",
	"res://Scenes/level_5.tscn",
	"res://Scenes/level_6.tscn",
	]



func load_level():
	if next_level<len(level_list):
		get_tree().change_scene_to_file(level_list[next_level])
	else:
		#game_complete
		get_tree().change_scene_to_file("res://Scenes/game_complete.tscn")
