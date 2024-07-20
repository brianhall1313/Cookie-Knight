extends Sprite2D

var cookie_value = 6
var pickup:bool = false
# Called when the node enters the scene tree for the first time.

func restore():
	show()
	pickup = false


func _on_area_2d_body_entered(body):
	if body.has_method("get_cookie") and not pickup:
		GlobalSignalBus.cookie_pickup.emit(self)
		body.get_cookie(cookie_value)
		hide()
		pickup = true
