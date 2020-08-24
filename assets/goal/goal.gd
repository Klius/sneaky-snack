extends Sprite
signal level_complete


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	passvb              .ñ-


func _on_goal_body_entered(_body):
	emit_signal("level_complete")
