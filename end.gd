extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = false
	$MarginContainer/VBoxContainer/CenterContainer/back.grab_focus()


func _on_back_pressed():
	get_tree().change_scene("res://main-menu.tscn")
