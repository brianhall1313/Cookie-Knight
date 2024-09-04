extends AnimatedSprite2D


var disabled:bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	play("active")
	GlobalSignalBus.connect("switch_toggled_on",restore)
	GlobalSignalBus.connect("switch_toggled_off",deactivate)

func deactivate(_s = null):
	play("disabled")
	disabled = true

func restore(_s = null):
	play("active")
	disabled = false

func _on_area_2d_body_entered(body):
	if body.is_in_group("player") and not disabled:
		GlobalSignalBus.player_death.emit()
		var new = Global.bloodsplosion.instantiate()
		get_tree().get_current_scene().add_child(new)
		new.position = body.position
		new.emitting = true
	
