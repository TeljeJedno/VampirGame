extends Node2D

enum BEHAVIOURS {IDLE, ROAM, RUN, AIMING, RETURNING}
var behaviour = BEHAVIOURS.IDLE
var behaviourTimer = 2
@onready var behaviour_timer = $BehaviourTimer
@onready var shoot_timer = $ShootTimer

const ARROW_2 = preload("res://Objects/arrow_2.tscn")

var move_spd_base = 1
var move_spd = 1
var move_dir = 0

var originPos
var target: CharacterBody2D
var shootSpeed = 2
var moveDist = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	originPos = position
	behaviour_timer.start(behaviourTimer + randf_range(-1, 1))
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):			
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
		print("AIMING")
		behaviour = BEHAVIOURS.AIMING
		move_dir = 0
		behaviour_timer.stop()
		shoot_timer.start(shootSpeed)
	pass # Replace with function body.

func shoot():
	var instance = ARROW_2.instantiate()
	instance.position = global_position
	instance.targetPos = target.position - global_position
	get_parent().add_child.call_deferred(instance)
	print("SHOT")
	pass
	
func _on_shoot_timer_timeout():
	shoot()
	pass # Replace with function body.

func _on_agro_area_body_exited(body):
	if body.name == "Player":
		behaviour = BEHAVIOURS.IDLE
		move_dir = 0
		behaviour_timer.start(0.5)
	pass # Replace with function body.


