extends Node2D

enum BEHAVIOURS {IDLE, ROAM, RUN, CHASE, RETURNING}
var behaviour = BEHAVIOURS.IDLE
var behaviourTimer = 2
@onready var behaviour_timer = $BehaviourTimer

var move_spd_base = 1
var move_spd = 1
var move_dir = 0


var originPos
var target: CharacterBody2D
var moveDist = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	originPos = position
	behaviour_timer.start(behaviourTimer + randf_range(-1, 1))
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if behaviour == BEHAVIOURS.CHASE: 
		move_dir = sign(target.position.x - position.x)
			
	if behaviour == BEHAVIOURS.RETURNING: if abs(position.x - originPos.x) < move_spd :
		behaviour = BEHAVIOURS.IDLE
		move_dir = 0
		behaviour_timer.start(behaviourTimer + randf_range(-1, 1)) 

	if abs(position.x - originPos.x) > moveDist : 
		print("RETURNING") 
		behaviour  = BEHAVIOURS.RETURNING
		move_dir = sign(originPos.x - position.x)
	
	position.x += move_dir * move_spd

	
func _on_behaviour_timer_timeout():
	behaviour = randi_range(0, 2)
	match behaviour:
		BEHAVIOURS.IDLE:
			move_dir = 0
			print("idleing")
		BEHAVIOURS.ROAM: 
			move_spd = move_spd_base
			var ranNum =  bool(randi() % 2)
			if ranNum: move_dir = -1
			else: move_dir = 1 
			print("roaming")
		BEHAVIOURS.RUN: 
			move_spd = move_spd_base * 2
			var ranNum =  bool(randi() % 2)
			if ranNum: move_dir = -1
			else: move_dir = 1 
			print("running")
			

func _on_agro_area_body_entered(body):
	if body.name == "Player":
		target = body
		print("CHASING")
		behaviour = BEHAVIOURS.CHASE
		move_dir = sign(body.position.x - position.x)
		behaviour_timer.stop()
	pass # Replace with function body.

func _on_agro_area_body_exited(body):
	if body.name == "Player":
		behaviour = BEHAVIOURS.RETURNING
		move_dir = sign(originPos.x - position.x)
	pass # Replace with function body.


func _on_attack_area_body_entered(body):
	if body.name == "Player":
		print("attack")
		#$AnimatedSprite.play(“the name of your animation”)	
	pass # Replace with function body.
	
func _on_damage_area_body_entered(body):
	if body.name == "Player":
		print("damage player")
	pass # Replace with function body.


