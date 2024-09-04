extends Node2D

@onready var hint = $hint
@onready var sprite = $sprite

var toggled:bool = false


func _ready():
	y_sort_enabled=true
	

func toggle():
	if not toggled:
		sprite.flip_h = not sprite.flip_h
		toggled = true
		hint.hide()
		GlobalSignalBus.switch_toggled_off.emit(self)
	else:
		sprite.flip_h = not sprite.flip_h
		toggled = false
		hint.show()
		GlobalSignalBus.switch_toggled_on.emit(self)



func _on_area_2d_body_entered(body):
	if body.has_method("set_flipable") and not toggled:
		hint.show()
		body.set_flipable(true,self)


func _on_area_2d_body_exited(body):
	if body.has_method("set_flipable"):
		hint.hide()
		body.set_flipable(false)
