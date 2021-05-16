extends Control

signal resume
signal restart
signal exit

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var currentAudio = ""
# Called when the node enters the scene tree for the first time.
func _ready():
	$centermenu/list/title/RichTextLabel.bbcode_text = "[center]"+tr("title_pause")
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
		$centermenu/list/playbtns/btncontinue.grab_focus()
		


func _on_play_audio(name):
	var audioplayer = get_node(name.to_lower())
	if not audioplayer.is_playing():
		audioplayer.play()


func _on_stop_audio(name):
	if name != currentAudio:
		var audioplayer = get_node(name.to_lower())
		audioplayer.stop()
		currentAudio = name
