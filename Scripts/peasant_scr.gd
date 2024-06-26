extends Node2D

enum BEHAVIOURS {IDLE, ROAM, RUN, RETURNING}
var behaviour = BEHAVIOURS.IDLE
var behaviourTimer = 0.1
@onready var behaviour_timer = $BehaviourTimer

var move_spd_base = 30
var move_spd = 30
var move_dir = 0

var originPos
var moveDist = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	move_spd = move_spd_base
	originPos = position
	behaviour_timer.start(behaviourTimer)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	
	if behaviour == BEHAVIOURS.RETURNING: if abs(position.x - originPos.x) < move_spd :
		behaviour = BEHAVIOURS.IDLE
		move_dir = 0
		behaviour_timer.start(behaviourTimer) 
	
	if abs(position.x - originPos.x) > moveDist : 
		behaviour  = BEHAVIOURS.RETURNING
		move_dir = sign(originPos.x - position.x)

	position.x += move_dir * move_spd * delta
	
	
func _on_behaviour_timer_timeout():
	behaviour = 0
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
			
