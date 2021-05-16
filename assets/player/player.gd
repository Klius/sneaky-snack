extends KinematicBody2D

export var speed = 100
export (NodePath) var joystickLeftPath
onready var joystickLeft : Joystick = get_node(joystickLeftPath)
var XSpeed = 0
var YSpeed = 0
var Facing = true # true is front false is back
var target = Vector2()
var screen_size
signal can_use
var near_box = false
var using_box = false
var use_box_delay = 0.2
var velocity = Vector3()
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
	use_box_delay -= _delta
	XSpeed = 0
	YSpeed = 0
	if Input.is_action_pressed("use") and near_box and use_box_delay < 0 :
		using_box = true
		equip_box()
		use_box_delay = 0.2
	elif Input.is_action_pressed("use") and using_box and use_box_delay < 0 :
		using_box = false
		equip_box()
		use_box_delay = 0.2
	if joystickLeft and joystickLeft.is_working:
		XSpeed = velocity.x
		YSpeed = velocity.y
			#target = get_global_position()
		if not using_box:
			if YSpeed < 0:
				$sprite.animation = "back"
			else:
				$sprite.animation = "front"
			if XSpeed < 0:
				$sprite.flip_h = true
				$cat_occluder.scale.x = -1
			else:
				$sprite.flip_h = false
				$cat_occluder.scale.x = 1
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
	velocity = Vector2()
	if joystickLeft and joystickLeft.is_working:
		velocity = move_and_slide(joystickLeft.output * speed)

	#move_and_slide(Vector2(XSpeed, YSpeed))
	#for i in get_slide_count():
	#	var collision = get_slide_collision(i)
		#print_debug("I collided with ", collision.collider.name)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func equip_box():
	if using_box:
		get_node("/root/world/box").equip()
		$sprite.animation = "in_box"
		$box_shape.disabled = false
		$box_occluder.visible = true
		$cat_shape.disabled = true
	else:
		get_node("/root/world/box").place(global_position)
		$sprite.animation = "front"
		$box_shape.disabled = true
		$box_occluder.visible = false
		$cat_shape.disabled = false

func _on_use_area_entered(area):
	if area.name == "box":
		emit_signal("can_use",true)
		near_box = true


func _on_use_zone_area_exited(area):
	if area.name == "box" :
		if using_box == false :
			emit_signal("can_use",false)
		near_box = false
