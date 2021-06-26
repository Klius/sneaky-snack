extends Node2D

var level_prefix="res://assets/level/"
var NOISE_FLOORS = ["Water"]
var NOISE = null
var WATER_FOOTSTEPS = null
var fail_jingle 
var success_jingle

var restart = false

var pause_timer = 0
var noise_timer = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	success_jingle = preload("res://audio/success.ogg")
	fail_jingle = preload("res://audio/fail.ogg")
	NOISE = preload("res://assets/noise/noise.tscn")
	WATER_FOOTSTEPS = preload("res://assets/water-footstep/water-footstep.tscn")
	get_tree().paused = true
# warning-ignore:return_value_discarded
	get_node("goal").connect("level_complete",self,"on_level_complete")
# warning-ignore:return_value_discarded
	get_node("CanvasLayer/pause").connect("resume",self,"pause")
# warning-ignore:return_value_discarded
	get_node("CanvasLayer/pause").connect("restart",self,"restart_level")
# warning-ignore:return_value_discarded
	get_node("CanvasLayer/pause").connect("exit",self,"back_to_menu")
	get_node("CanvasLayer/level_intro").connect("start_level",self,"start_level")

func pause():
	$CanvasLayer/pause.visible = !$CanvasLayer/pause.visible
	$CanvasLayer/touchbtn.visible = !$CanvasLayer/pause.visible
	get_tree().paused = $CanvasLayer/pause.visible
	
func _process(_delta):
	pause_timer -= _delta
	noise_timer -= _delta
	get_cell()
	if Input.is_action_pressed("pause") and pause_timer < 0:
		pause()
		pause_timer = 0.5

func on_level_complete():
	$sfx.set_stream(success_jingle)
	$sfx.play()
	global.register_record(get_node("CanvasLayer/countdown").get_time_millis())
	global.current_level +=1
	global.levels[global.current_level]["playable"] = true
	global.save_config()
	get_tree().paused = true
	
	
func change_level():	
# warning-ignore:return_value_discarded
	var level = level_prefix+global.levels[global.current_level]["scene"]
	get_tree().change_scene(level)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func on_spotted():
	restart = true
	$sfx.set_stream(fail_jingle)
	$sfx.play()
	get_tree().paused = true
	
	
func restart_level():
# warning-ignore:return_value_discarded
	var level = level_prefix+global.levels[global.current_level]["scene"]
	get_tree().change_scene(level)


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
	if $Player.XSpeed != 0 or $Player.YSpeed !=0:
		var tile_pos = $Navigation/TileMap.world_to_map($Player.global_position)
		var cell = $Navigation/TileMap.get_cellv(tile_pos)
		#print($Navigation/TileMap.tile_set.tile_get_name(cell))
		if $Navigation/TileMap.tile_set.tile_get_name(cell) in NOISE_FLOORS and noise_timer < 0 :
			spawn_noise($Player.global_position,"water")
		if get_node_or_null("TileMap"):
			if $Navigation/TileMap.tile_set.tile_get_name(cell) == "background":
				$TileMap.modulate = Color(1.0,1.0,1.0,0.8)
			else:
				$TileMap.modulate = Color(1.0,1.0,1.0,1.0)

func spawn_noise(pos, type):
	noise_timer = 0.1
	var new_noise = NOISE.instance()
	var footstep = WATER_FOOTSTEPS.instance()
	new_noise.global_position = pos
	footstep.global_position = pos
	add_child(new_noise)
	add_child(footstep)
	


func start_level():
	get_tree().paused = false

