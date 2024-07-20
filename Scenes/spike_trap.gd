extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	play("active")
	GlobalSignalBus.connect("switch_toggled_on",restore)
	GlobalSignalBus.connect("switch_toggled_off",deactivate)

func deactivate(_s = null):
	play("disabled")

func restore(_s = null):
	play("active")

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		GlobalSignalBus.player_death.emit()
