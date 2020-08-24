extends Control
var LEVELS = [
	"res://assets/level/level-01.tscn",
	"res://assets/level/level-02.tscn",
	"res://assets/level/level-03.tscn",
	"res://assets/level/level-04.tscn",
	"res://assets/level/level-05.tscn",
	"res://assets/level/level-06.tscn",
	"res://assets/level/level-07.tscn",
	"res://assets/level/level-08.tscn",
	"res://assets/level/level-09.tscn",
	"res://assets/level/level-10.tscn",
	"res://assets/level/level-11.tscn"
]

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$"Main/VBoxContainer/CenterContainer2/HBoxContainer/BtnStart".grab_focus()



func _on_BtnStart_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://assets/level/level-01.tscn")


func start_level(idx):
# warning-ignore:return_value_discarded
	get_tree().change_scene(LEVELS[idx])


func _on_BtnSelect_pressed():
	$Main.visible = false
	$Level.visible = true
	$"Level/CenterContainer/GridContainer/level-01/CenterContainer2/btn01".grab_focus()
