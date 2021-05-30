extends KinematicBody2D

signal spotted
export var speed = 40
export var  wait_time:float =  2.0
export var restricted:bool = false
export var max_degrees = 180
export var min_degrees = 0
var direction = 1
var wait = 0
onready var rays = $rays.get_children()
# Called when the node enters the scene tree for the first time.
func _ready():
	for ray in rays:
		ray.add_exception(self)
func _physics_process(delta):
	#Detection
	for ray in rays:
		if ray.is_colliding():
			var body = ray.get_collider()
			if body.get_name() == "Player":
				if not body.using_box:
					emit_signal("spotted")
				if body.using_box and body.velocity != Vector2(0,0):
					print(body.velocity)
					emit_signal("spotted")
	#PATROL LOGIC
	wait -=delta
	if wait >= 0:
		return
	if not restricted:
		rotation_degrees += speed*delta
	else:
		rotation_degrees += (direction*speed)*delta
		if abs(rotation_degrees) >= abs(max_degrees):
			rotation_degrees = max_degrees
			direction *= -1
		if abs(rotation_degrees) <= abs(min_degrees):
			rotation_degrees = min_degrees
			direction *= -1

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


