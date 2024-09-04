extends Sprite2D


const SPEED = 150
var rotation_speed

func _ready():
	rotation_speed = .06


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y += delta * SPEED
	rotation += rotation_speed
