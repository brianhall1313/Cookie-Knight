extends Node2D

@onready var player = $player
@onready var map = $map
@onready var ui = $UI


@export var stamina = 20

var player_move_history:Array = []


var directions:Dictionary={
	"down":Vector2i(0,1),
	"up":Vector2i(0,-1),
	"left":Vector2i(-1,0),
	"right":Vector2i(1,0),
}


# Called when the node enters the scene tree for the first time.
func _ready():
	player.position=map.map_to_local(Vector2i(1,1))
	player.set_stamina(stamina)
	connect_to_global_signal_bus()
	ui_init()
	var new = Global.wipe.instantiate()
	add_child(new)
	new.wipe_in()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func connect_to_global_signal_bus():
	GlobalSignalBus.connect("move_player",move_entity)
	GlobalSignalBus.connect("player_death",player_death)
	GlobalSignalBus.connect("move_box",move_entity)
	GlobalSignalBus.connect("enemy_hit",enemy_hit)
	GlobalSignalBus.connect("cookie_pickup",cookie_pickup)
	GlobalSignalBus.connect("ultimate",ultimate)
	GlobalSignalBus.connect("switch_toggled_off",switch_off)


func cookie_pickup(cookie):
	player_move_history.append({"entity":cookie})


func move_entity(entity,direction:String):
	if directions.has(direction):
		var previous = map.local_to_map(entity.position)
		player_move_history.append({"entity":entity,"move":previous})
		var next = previous+directions[direction]
		entity.position = map.map_to_local(next)
		player.spend_stam()


func undo_player_move():
	if len(player_move_history)>0:
		var move = player_move_history.pop_back()
		if move["entity"].is_in_group("cookie"):
			player.spend_stam(move["entity"].cookie_value)
			undo_player_move()
			move["entity"].restore()
		elif move["entity"].is_in_group("enemy"):
			move["entity"].restore()
			player.gain_stamina(1)
		elif move["entity"].is_in_group("switch"):
			move["entity"].toggle()
			player.gain_stamina(1)
		elif move["entity"].is_in_group("mover"):
			move["entity"].position = map.map_to_local(move["move"])
			player.gain_stamina(1)
	



func player_death():
	reset()


func reset():
	var new = Global.wipe.instantiate()
	add_child(new)
	new.wipe_out()
	await GlobalSignalBus.transition_done
	get_tree().reload_current_scene()


func ui_init():
	ui.initial(stamina)

func enemy_hit(enemy):
	player_move_history.append({"entity":enemy})
	player.spend_stam()


func _on_quit_button_button_up():
	var new = Global.wipe.instantiate()
	add_child(new)
	new.wipe_out()
	await GlobalSignalBus.transition_done
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_reset_button_button_up():
	reset()


func _on_undo_button_button_up():
	$UI/undo_button.release_focus()
	undo_player_move()

func ultimate():
	print("WIN!")
	get_tree().quit()


func switch_off(switch):
	player_move_history.append({"entity":switch})


