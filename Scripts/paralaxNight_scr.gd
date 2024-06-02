extends ParallaxBackground

var player 
@onready var control = $ParallaxLayer3/Sprite2D/Control
var startSize

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent().get_node("Player") 
	startSize = control.size.x
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	control.size.x = float(player.blood_bar) / float(100) * startSize
	pass
