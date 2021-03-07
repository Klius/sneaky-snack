extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var bus = ""
export var maxdb = 0
export var label = "Music"
signal play_audio 
signal stop_audio

# Called when the node enters the scene tree for the first time.
func _ready():
	$title.text = label
	bus = AudioServer.get_bus_index(bus)
	$HBoxContainer/slider.value = db2linear(AudioServer.get_bus_volume_db(bus))



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass




func _on_btnMute_pressed():
	AudioServer.set_bus_mute(bus,true)
	$HBoxContainer/slider.value = linear2db(0)


func _on_btnfull_pressed():
	AudioServer.set_bus_mute(bus,false)
	AudioServer.set_bus_volume_db(bus,maxdb)
	$HBoxContainer/slider.value = db2linear(AudioServer.get_bus_volume_db(bus))
	


func _on_slider_value_changed(value):
	AudioServer.set_bus_mute(bus,false)
	AudioServer.set_bus_volume_db(bus,linear2db(value))


func _on_focus_entered():
	emit_signal("play_audio",label)


func _on_focus_exited():
	emit_signal("stop_audio",label)
