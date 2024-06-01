extends Node2D

enum BEHAVIOURS {IDLE, ROAM, RUN, CHASE}
var behaviour = BEHAVIOURS.IDLE
var rng = RandomNumberGenerator.new()
@onready var behaviour_timer = $BehaviourTimer

var move_spd_base = 1
var move_spd = 1
var move_dir = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	behaviour_timer.start()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x += move_dir * move_spd

	
	
func _on_behaviour_timer_timeout():
	behaviour = BEHAVIOURS.IDLE
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
	print(body.name)
	if body.name == "Player":
		print("CHASING")
		behaviour = BEHAVIOURS.CHASE
		behaviour_timer.stop()
	pass # Replace with function body.
