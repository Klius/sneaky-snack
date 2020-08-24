extends KinematicBody2D

signal spotted
var move_to = Vector2(0,0)
export var speed = 40
export var  wait_time:float =  2.0
export var disabled = false
var next_rotation = 0
export var path_name = "Points"
var  wait = 0
var is_waiting = false
var eps = 1.5
onready var nav = get_parent().get_node("Navigation")
onready var path = get_parent().get_node(path_name).get_children()
var current_point = 1
onready var rays = $rays.get_children()
var points = []
# Called when the node enters the scene tree for the first time.
func _ready():
	for ray in rays:
		ray.add_exception(self)
func _physics_process(delta):
	#Detection
	if disabled:
		return
	for ray in rays:
		if ray.is_colliding():
			var body = ray.get_collider()
			if body.get_name() == "Player":
				emit_signal("spotted")
	#PATROL LOGIC
	wait -=delta
	if wait >= 0:
		return
	if next_rotation != 0:
		rotate(next_rotation)
		next_rotation = 0	
	points = nav.get_simple_path(get_global_position(),path[current_point].get_global_position())
	if points.size() > 1:
		var distance = points[1] -get_global_position()
		var direction = distance.normalized()
		if distance.length() > eps or points.size() > 2:
# warning-ignore:return_value_discarded
			move_and_slide(direction*speed)
		else:
			wait = wait_time
			next_rotation = path[current_point].get_rotation()
			current_point += 1
			if current_point == path.size():
				current_point = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func spotted_something(_body):
	pass
	#emit_signal("spotted")
