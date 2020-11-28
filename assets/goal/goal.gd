extends Sprite
signal level_complete

var TIME = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	TIME += delta 
	self.modulate = Color(clamp(sin(TIME),0.5,1),1,clamp(cos(TIME),0.5,1))


func _on_goal_body_entered(_body):
	emit_signal("level_complete")
