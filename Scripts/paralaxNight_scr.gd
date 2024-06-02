extends Node2D

@onready var player = $".."
@onready var control = $Sprite2D/Control
var startSize
var moonYPos = -300
# Called when the node enters the scene tree for the first time."res://Scripts/"
func _ready():
	startSize = control.size.x


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	set_global_position(Vector2(get_global_position().x, moonYPos))
	control.size.x = float(player.blood_bar) / float(100) * startSize
	

