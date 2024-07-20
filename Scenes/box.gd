extends CharacterBody2D

@onready var down = $down
@onready var up = $up
@onready var right = $right
@onready var left = $left




@onready var push_dir:Dictionary={
	"down":down,
	"up":up,
	"right":right,
	"left":left
}


func _ready():
	y_sort_enabled=true



func push(direction):
	if push_dir.has(direction):
		var collider = push_dir[direction].get_collider()
		if not collider:
			GlobalSignalBus.move_box.emit(self,direction)
		else:
			print("box cannot move")
