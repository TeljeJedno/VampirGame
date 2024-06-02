extends ParallaxBackground

var player 
@onready var control = $ParallaxLayer3/Sprite2D/Control

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent().get_node("Player") 
	print(player.name)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	control.size.x = player.blood_bar / 100
	pass
