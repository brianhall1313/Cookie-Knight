extends CharacterBody2D


func _ready():
	$AnimatedSprite2D.play("idle")


func get_hit():
	hide()
	var new = Global.bloodsplosion.instantiate()
	get_tree().get_current_scene().add_child(new)
	new.position = position
	new.emitting = true
	$CollisionShape2D.disabled = true
	GlobalSignalBus.enemy_hit.emit(self)

func restore():
	show()
	$CollisionShape2D.disabled = false
