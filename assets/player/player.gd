extends KinematicBody2D

export var speed = 50
export (NodePath) var joystickLeftPath
onready var joystickLeft : Joystick = get_node(joystickLeftPath)
var XSpeed = 0
var YSpeed = 0
var Facing = true # true is front false is back
var target = Vector2()
var screen_size
# Called when the node enters the scene tree for the first time.
func _ready():
	target = get_position()
	screen_size = get_viewport_rect().size

#func _input(event):
#	if get_tree().paused :
#		target = global_position
#	if event is InputEventScreenTouch and event.pressed:
#		target = (global_position - (get_viewport_rect().size / 2)) + event.position
#	if event is InputEventScreenDrag:
#		target = (global_position - (get_viewport_rect().size / 2)) + event.position
#	if event is InputEventScreenTouch and !event.pressed:
#		target = global_position
#		$Line2D.points[1] = Vector2()
	
func _process(_delta):
	XSpeed = 0
	YSpeed = 0
	if joystickLeft and joystickLeft.is_working:
		var velocity = move_and_slide(joystickLeft.output * speed)
		XSpeed = velocity.x
		YSpeed = velocity.y
			#target = get_global_position()
		if YSpeed < 0:
			$sprite.animation = "back"
		else:
			$sprite.animation = "front"
		if XSpeed < 0:
			$sprite.flip_h = true
			$LightOccluder2D.scale.x = -1
		else:
			$sprite.flip_h = false
			$LightOccluder2D.scale.x = 1
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
	if joystickLeft and joystickLeft.is_working:
		var _velocity = move_and_slide(joystickLeft.output * speed)
	#move_and_slide(Vector2(XSpeed, YSpeed))
	#for i in get_slide_count():
	#	var collision = get_slide_collision(i)
		#print_debug("I collided with ", collision.collider.name)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
