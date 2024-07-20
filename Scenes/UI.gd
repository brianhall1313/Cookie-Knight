extends Control

@onready var player_stamina = $GridContainer/player_stamina

# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalSignalBus.connect("player_stamina",update_stamina)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func initial(max_stam):
	player_stamina.text = str(max_stam)
	$GridContainer/max_stamina.text = str(max_stam)

func update_stamina(stam):
	if stam <=5:
		player_stamina.modulate = Color("red")
	else:
		player_stamina.modulate = Color("white")
		
	player_stamina.text = str(stam)
	
