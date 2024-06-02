extends Path2D

var speed = 700
var targetPos: Vector2
@onready var path_follow_2d = $PathFollow2D

# Called when the node enters the scene tree for the first time.
func _ready():
	curve.set_point_out(0, Vector2(targetPos.x/2, - abs(targetPos.x)))
	curve.set_point_position(1, targetPos)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if path_follow_2d.progress_ratio >= 0.98: queue_free()
	path_follow_2d.progress += speed * delta
	pass

func _on_area_2d_body_entered(body):
	match body.name:
		"Player":
			body.change_hp(-15)
