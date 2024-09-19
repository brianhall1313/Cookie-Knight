extends Control


var move_range: float = 320
var left_start_position:Vector2 = Vector2(-1 * move_range,0)
var right_start_position:Vector2 = Vector2(move_range,0)
var mid: Vector2 = Vector2(0,0)

@onready var wipe_rect = $wipe_rect

func _ready():
	global_position = left_start_position



func wipe_right():
	GlobalSignalBus.transition_start.emit()
	wipe_rect.global_position = left_start_position
	var tween = get_tree().create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(wipe_rect, "global_position:x", mid.x, .5).from(wipe_rect.global_position.x)
	await tween.finished
	GlobalSignalBus.transition_done.emit()
	queue_free()

func wipe_left():
	GlobalSignalBus.transition_start.emit()
	wipe_rect.global_position = mid
	var tween = get_tree().create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(wipe_rect, "global_position:x", right_start_position.x, .5).from(wipe_rect.global_position.x)
	await tween.finished
	GlobalSignalBus.transition_done.emit()
	queue_free()

func wipe_out():
	GlobalSignalBus.transition_start.emit()
	wipe_rect.global_position = right_start_position
	var tween = get_tree().create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(wipe_rect, "global_position:x", mid.x, .5).from(wipe_rect.global_position.x)
	await tween.finished
	GlobalSignalBus.transition_done.emit()
	queue_free()


func wipe_in():
	GlobalSignalBus.transition_start.emit()
	wipe_rect.global_position = mid
	var tween = get_tree().create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(wipe_rect, "global_position:x", left_start_position.x, .5).from(wipe_rect.global_position.x)
	await tween.finished
	GlobalSignalBus.transition_done.emit()
	queue_free()
