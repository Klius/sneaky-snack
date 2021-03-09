extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$"Main/VBoxContainer/CenterContainer2/HBoxContainer/BtnStart".grab_focus()
	$LevelSelect.connect("back_to_main_menu",self,"back_from_level_select")


func _on_BtnStart_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://assets/level/level-01.tscn")


func _on_BtnSelect_pressed():
	$Main.visible = false
	$LevelSelect.visible = true

func back_from_level_select():
	$Main.visible = true
	$LevelSelect.visible = false
	$"Main/VBoxContainer/CenterContainer2/HBoxContainer/BtnSelect".grab_focus()
