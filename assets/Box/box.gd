extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func _ready():
	pass


func equip():
	visible = false
	$CollisionShape2D.disabled = true
	$box/CollisionShape2D.disabled=true

func place(position):
	global_position = position
	global_position.y -= 16
	visible = true
	$box/CollisionShape2D.disabled= false
	$CollisionShape2D.disabled = false
