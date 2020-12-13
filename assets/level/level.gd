extends Node2D

export var next_level = "res://assets/level/level-02.tscn"
export var this_level = "res://assets/level/level-01.tscn"

var fail_jingle 
var success_jingle

var restart = false

var pause_timer = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	success_jingle = preload("res://audio/success.ogg")
	fail_jingle = preload("res://audio/fail.ogg")
	get_tree().paused = false
# warning-ignore:return_value_discarded
	get_node("goal").connect("level_complete",self,"on_level_complete")
# warning-ignore:return_value_discarded
	get_node("CanvasLayer/pause").connect("resume",self,"pause")
# warning-ignore:return_value_discarded
	get_node("CanvasLayer/pause").connect("restart",self,"restart_level")
# warning-ignore:return_value_discarded
	get_node("CanvasLayer/pause").connect("exit",self,"back_to_menu")
	
func pause():
	$CanvasLayer/pause.visible = !$CanvasLayer/pause.visible
	get_tree().paused = $CanvasLayer/pause.visible
	
func _process(_delta):
	pause_timer -= _delta
	get_cell()
	if Input.is_action_pressed("pause") and pause_timer < 0:
		pause()
		pause_timer = 0.5

func on_level_complete():
	$sfx.set_stream(success_jingle)
	$sfx.play()
	get_tree().paused = true
	
func change_level():	
# warning-ignore:return_value_discarded
	get_tree().change_scene(next_level)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func on_spotted():
	restart = true
	$sfx.set_stream(fail_jingle)
	$sfx.play()
	get_tree().paused = true
	#restart_level()
	
	
func restart_level():
# warning-ignore:return_value_discarded
	get_tree().change_scene(this_level)


func back_to_menu():
	get_tree().paused = false
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://main-menu.tscn")

func _on_sfx_finished():
	if restart:
		restart_level()
	else:
		change_level()

func get_cell():
	var tile_pos = $Navigation/TileMap.world_to_map($Player.global_position)
	var cell = $Navigation/TileMap.get_cellv(tile_pos)
	#print($Navigation/TileMap.tile_set.tile_get_name(cell))
