extends Node
@onready var bgm = $BGM
@onready var walk_1 = $walk1
@onready var walk_2 = $walk2
@onready var push = $push
@onready var switch = $switch
@onready var eat_cookie = $eat_cookie
@onready var win = $win
@onready var die = $die
@onready var stab = $stab
@onready var undo = $undo

signal win_audio_done
# Called when the node enters the scene tree for the first time.
func _ready():
	bgm.play()

func walk():
	walk_1.play()
	await walk_1.finished
	walk_2.play()
	await walk_2.finished

func win_audio():
	win.play()
	await win.finished
	win_audio_done.emit()
