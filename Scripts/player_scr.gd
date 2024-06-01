extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var dash = false
var movable = true
var blood_bar = 1
var jump_charges = 2
var bodies = []
@onready var action_timer = $Timer
@onready var attack_range = $AttackRange

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	print(dash)
	if is_on_floor():
		jump_charges = 2
		
	# Add the gravity.
	if not is_on_floor():
		if dash == false:
			velocity.y += gravity * delta
		else:
			velocity.y = 0

	# Handle jump.
	if Input.is_action_just_pressed("jump") and jump_charges > 0:
		velocity.y = JUMP_VELOCITY
		jump_charges -= 1	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	
	if direction:	
		#Handle dash
		if Input.is_action_just_pressed("dash"):			
			action_timer.start()
			dash = true;
			
		if dash == true:
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

#func _on_area_2d_body_entered(body):
	#if victim == null:
		#victim = body
	#else:
		#if victim.name == "Peasant":
			#pass
		#elif victim.name == "Knight":
			#if body.name == "Peasant":
				#victim = body
				
func checkArea():
	bodies = attack_range.get_overlapping_bodies()
	var body_names = []
	if bodies.size() == 0:
		return
	else:
		for b in bodies:
			body_names.append(b.name)
		if "Peasant" in body_names:
			pass
		elif "Knight" in body_names:
			pass
