extends CharacterBody2D

@onready var down = $down
@onready var up = $up
@onready var right = $right
@onready var left = $left
@onready var sprite = $Sprite
@onready var direction_dictionary:Dictionary={
	"down":down,
	"up":up,
	"right":right,
	"left":left
}


@export var max_stamina:int
@export var stamina:int


var dead: bool = false
var moving:bool = false 
var flipable: bool = false
var flip_target=null


func _ready():
	sprite.play("Idle")
	y_sort_enabled=true
	GlobalSignalBus.connect("player_death",death)


func _physics_process(_delta):
	if not moving and not dead:
		check_movement()
		check_flip()


func set_stamina(new_stamina):
	max_stamina=new_stamina
	stamina = max_stamina

func check_movement():
	var direction: String =""
	if Input.is_action_just_pressed("down"):
		direction = go_here("down")
	elif Input.is_action_just_pressed("up"):
		direction = go_here("up")
	elif Input.is_action_just_pressed("left"):
		direction = go_here("left")
	elif Input.is_action_just_pressed("right"):
		direction = go_here("right")
	if direction:
		GlobalSignalBus.move_player.emit(self,direction)
		
func check_stamina():
	if stamina<0:
		AudioController.die.play()
		GlobalSignalBus.player_death.emit()


func check_flip():
	if Input.is_action_just_pressed("action"):
		if flipable and flip_target.has_method("toggle"):
			flip_target.toggle()
			set_flipable(false)
			spend_stam()

func go_here(direction):
	if direction_dictionary.has(direction):
		var collider = direction_dictionary[direction].get_collider()
		if not collider:
			print("clear")
			return direction
		else:
			print("collision")
			if collider.has_method("push"):
				collider.push(direction)
			elif collider.has_method("get_hit"):
				AudioController.stab.play()
				collider.get_hit()
	return ""


func spend_stam(cost = 1):
	stamina -= cost
	GlobalSignalBus.player_stamina.emit(stamina)
	check_stamina()

func get_cookie(value):
	AudioController.eat_cookie.play()
	gain_stamina(value)
	GlobalSignalBus.player_stamina.emit(stamina)


func gain_stamina(value):
	stamina = clampi(value+stamina,0,max_stamina)
	GlobalSignalBus.player_stamina.emit(stamina)

func set_flipable(v:bool,target = null):
	flipable = v
	flip_target = target
	print("flipable: ",flipable," and the target ", flip_target)

func death():
	AudioController.die.play()
	dead = true
	sprite.hide()
	
