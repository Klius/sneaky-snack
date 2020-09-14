extends KinematicBody2D

export var speed = 100
var XSpeed = 0
var YSpeed = 0
var Facing = true # true is front false is back
var target = Vector2()
var screen_size
# Called when the node enters the scene tree for the first time.
func _ready():
	target = get_position()
	screen_size = get_viewport_rect().size
	
func _input(event):
	if event is InputEventScreenTouch and event.pressed:
		target = (global_position - (get_viewport_rect().size / 2)) + event.position
	if event is InputEventScreenDrag:
		target = (global_position - (get_viewport_rect().size / 2)) + event.position
	if event is InputEventScreenTouch and !event.pressed:
		target = global_position
		
func _process(_delta):
	XSpeed = 0
	YSpeed = 0
	if OS.get_name() == "Android":
		if get_position().distance_to(target) > 10:
			var velocity = target - get_position()
			velocity = velocity.normalized() * speed
			XSpeed = velocity.x
			YSpeed = velocity.y
			#target = get_global_position()
			#look_at(velocity)
	else:
		if Input.is_action_pressed("up"):
			YSpeed = -speed
			rotation_degrees = 180
		elif Input.is_action_pressed("down"):
			YSpeed = speed
			rotation_degrees = 0	
		if Input.is_action_pressed("left"):
			XSpeed = -speed
			rotation_degrees = 90
		elif Input.is_action_pressed("right"):
			XSpeed = speed
			rotation_degrees = -90
		
func _physics_process(_delta):
# warning-ignore:return_value_discarded
	move_and_slide(Vector2(XSpeed, YSpeed))
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
