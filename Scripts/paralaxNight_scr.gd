extends Node2D

@onready var player = $".."
@onready var control = $Sprite2D/Control
var startSize

# Called when the node enters the scene tree for the first time."res://Scripts/"
func _ready():
	startSize = control.size.x
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	control.size.x = float(player.blood_bar) / float(100) * startSize
	pass
