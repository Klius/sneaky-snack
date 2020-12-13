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
var noise_point = null
var noise_investigation = 0
var rotation_after_noise = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	for ray in rays:
		ray.add_exception(self)
		
func investigate_noise(delta):
	wait -=delta
	if wait >=0:
		return
	points = nav.get_simple_path(get_global_position(),noise_point)
	print(points.size())
	if points.size() > 1:
		var distance = points[1] -get_global_position()
		var direction = distance.normalized()
		if distance.length() > eps or points.size() > 2:
# warning-ignore:return_value_discarded
			move_and_slide(direction*speed)
			look_at(noise_point)
			rotation_degrees -=90
		else:
			if noise_investigation == 0:
				noise_investigation = 1
				rotation_degrees = 90
				wait = wait_time
			elif noise_investigation == 1:
				rotation_degrees = -90
				noise_investigation = 2
				wait = wait_time
			elif noise_investigation == 2:
				noise_point = null
				noise_investigation = 3
				look_at(path[current_point].get_global_position())
				rotation_degrees -=90

func _physics_process(delta):
	#Detection
	if disabled:
		return
	for ray in rays:
		if ray.is_colliding():
			var body = ray.get_collider()
			if body.get_name() == "Player":
				emit_signal("spotted")
	if noise_point != null:
		investigate_noise(delta)
	else:
		normal_patrol(delta)

#PATROL LOGIC
func normal_patrol(delta):
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
			if noise_investigation == 3:
				noise_investigation = 0
				rotation = rotation_after_noise
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


func _on_noise_detect_area_entered(area):
	noise_point=area.global_position
	rotation_after_noise = rotation
	look_at(noise_point)
	rotation_degrees -= 90
