extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("/root/world/Player").connect("can_use",self,"toogle_use_btn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func on_level_intro_start_level():
	$Joystick.set_visible(true)
	$touchbtn.set_visible(true)

func toogle_use_btn(toogle:bool):
	$usebtn.set_visible(toogle)
