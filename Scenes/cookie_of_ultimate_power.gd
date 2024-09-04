extends Sprite2D




func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		GlobalSignalBus.ultimate.emit()
		var new = Global.quickening.instantiate()
		get_tree().get_current_scene().add_child(new)
		new.position = body.position
