extends Node2D

enum BEHAVIOURS {IDLE, ROAM, RUN, CHASE, RETURNING}
var behaviour = BEHAVIOURS.IDLE
var behaviourTimer = 2
@onready var behaviour_timer = $BehaviourTimer
@onready var attack_timer = $AttackTimer
@onready var relax_timer = $RelaxTimer
@onready var damage_shape = $DamageArea/DamageShape

var move_spd_base = 100
var move_spd = 30
var move_dir = 0

var attacking
var originPos
var target: CharacterBody2D
var moveDist = 600

# Called when the node enters the scene tree for the first time.
func _ready():
	move_spd = move_spd_base
	originPos = position
	behaviour_timer.start(behaviourTimer + randf_range(-1, 1))
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if behaviour == BEHAVIOURS.CHASE: 
		move_dir = sign(target.position.x - position.x)
			
	if behaviour == BEHAVIOURS.RETURNING: if abs(position.x - originPos.x) < 2 :
		behaviour = BEHAVIOURS.IDLE
		move_dir = 0
		behaviour_timer.start(behaviourTimer + randf_range(-1, 1)) 

	if abs(position.x - originPos.x) > moveDist : 
		behaviour  = BEHAVIOURS.RETURNING
		move_dir = sign(originPos.x - position.x)
		
	if move_dir > 0:
		scale = Vector2(-0.5,0.5)
	else:
		scale = Vector2(0.5,0.5)


func _physics_process(delta):
	position.x += move_dir * move_spd * delta
	
func _on_behaviour_timer_timeout():
	behaviour = randi_range(0, 2)
	match behaviour:
		BEHAVIOURS.IDLE:
			move_dir = 0
		BEHAVIOURS.ROAM: 
			move_spd = move_spd_base
			var ranNum =  bool(randi() % 2)
			if ranNum: move_dir = -1
			else: move_dir = 1 
		BEHAVIOURS.RUN: 
			move_spd = move_spd_base * 2
			var ranNum =  bool(randi() % 2)
			if ranNum: move_dir = -1
			else: move_dir = 1 
			

func _on_agro_area_body_entered(body):
	if body.name == "Player":
		target = body
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
		attack_timer.start()

func _on_attack_timer_timeout():
	relax_timer.start()
	damage_shape.disabled = false

func _on_relax_timer_timeout():
	damage_shape.disabled = true

func _on_damage_area_body_entered(body):
	if body.name == "Player":
		body.change_hp(-20)
		damage_shape.disabled = true
