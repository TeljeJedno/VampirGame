extends CharacterBody2D

var max_speed = 20
var cur_vel = Vector2.ZERO

var target
var turn_spd = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	print("CREATED")
	cur_vel = max_speed * Vector2.RIGHT.rotated(rotation)
	
	
func _physics_process(delta):
	#var direction = global_position.direction_to(target.global_position)
	
	#var desired_vel = direction * max_speed
	#var change = (desired_vel - cur_vel) * turn_spd
	
	#cur_vel += change
	#position += cur_vel * delta
	#look_at(global_position +  cur_vel)
	pass
	
	
	
