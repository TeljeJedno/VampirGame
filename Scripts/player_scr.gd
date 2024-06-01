extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var dash = false
var movable = true
var blood_bar = 1
var jump_charges = 2
@onready var action_timer = $Timer

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	if is_on_floor():
		jump_charges = 2
		
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and jump_charges > 0:
		velocity.y = JUMP_VELOCITY
		jump_charges -= 1	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	
	if direction:	
		#Handle dash
		if Input.is_key_pressed(KEY_SHIFT):
			dash = true;
			
		if dash == true:
			action_timer.start()
			velocity.x = direction * SPEED * 5
		else:	
			velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func _on_timer_timeout():
	print(action_timer.time_left)
	dash = false
	
func change_hp (h):
	blood_bar += h
