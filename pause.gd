extends Control

signal resume
signal restart
signal exit

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_btncontinue_pressed():
	emit_signal("resume")


func _on_btnrestart_pressed():
	emit_signal("restart")


func _on_btnexit_pressed():
	emit_signal("exit")


func _on_pause_visibility_changed():
	if visible:
		$CenterContainer/VBoxContainer/CenterContainer/btncontinue.grab_focus()
		
