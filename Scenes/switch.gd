extends Node2D

@onready var hint = $hint
@onready var sprite = $sprite

var toggle_on = Rect2(32,80,16,16)
var toggle_off = Rect2(48,80,16,16)
var toggled:bool = false


func _ready():
	y_sort_enabled=true
	


func toggle():
	if not toggled:
		sprite.region_rect = toggle_off
		toggled = true
		hint.hide()
		GlobalSignalBus.switch_toggled_off.emit(self)
	else:
		sprite.region_rect = toggle_on
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
