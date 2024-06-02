extends CharacterBody2D

const SPEED = 400.0
const JUMP_VELOCITY = -600.0
var dash = false
var dashable = true
var blood_bar = 75
var jump_charges = 2
var bodies = []
@onready var action_timer = $Timer
@onready var attack_range = $AttackRange
@onready var cooldown_timer = $CooldownTimer

@export var forceRight = false



# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
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
	var direction = 0
	if forceRight:
		direction = 1
	else:
		direction = Input.get_axis("move_left", "move_right")
	
	if direction:	
		#Handle dash
		$PlayerBody/AnimationPlayer.play("RUN")
		if direction < 0:
			$PlayerBody.scale = Vector2(-0.2,0.2)
		else:
			$PlayerBody.scale = Vector2(0.2,0.2)
		if Input.is_action_just_pressed("dash") and dashable == true:			
			action_timer.start()
			dash = true;
			dashable = false
		if dash == true:
			velocity.x = direction * SPEED * 4
		else:	
			velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$PlayerBody/AnimationPlayer.play("RESET")

	move_and_slide()

func _on_timer_timeout():
	dash = false
	cooldown_timer.start()
	
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
		if "Knight" in body_names:
			pass
		elif "Peasant" in body_names:
			for b in bodies:
				if b.name == "Peasant":
					b.queue_free()	
		elif "Archer" in body_names:
			for b in bodies:
				if b.name == "Archer":
					b.queue_free()	


func _on_cooldown_timer_timeout():
	dashable = true # Replace with function body.
	

