extends KinematicBody2D

export var speed = 100
var XSpeed = 0
var YSpeed = 0
var Facing = true # true is front false is back
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func _process(_delta):
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
	XSpeed = 0
	YSpeed = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
