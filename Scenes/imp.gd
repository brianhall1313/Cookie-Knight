extends CharacterBody2D


func _ready():
	$AnimatedSprite2D.play("idle")


func get_hit():
	hide()
	$CollisionShape2D.disabled = true
	GlobalSignalBus.enemy_hit.emit(self)

func restore():
	show()
	$CollisionShape2D.disabled = false
