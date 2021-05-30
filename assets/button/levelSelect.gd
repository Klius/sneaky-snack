extends Control


signal back_to_main_menu
var thumbnail_path = "res://assets/level_thumbnails/"
var scene_path = "res://assets/level/"
var selected_level = 0
var button = "res://assets/button/button.tscn"
var global
# Called when the node enters the scene tree for the first time.
func _ready():
	$wrap/HBoxContainer/RichTextLabel.bbcode_text = "[center]"+tr("title_level_select")
	global = get_node("/root/global")
	var gridLevels = $wrap/main/levelcenter/levels
	var idx = 0
	for level in global.levels:
		var btn = load(button).instance()
		btn.set_text(str(idx+1))
		btn.size_flags_vertical = SIZE_EXPAND_FILL
		btn.connect("pressed",self,"_on_level_select",[idx])
		if level["playable"] == false:
			btn.disabled = true
		gridLevels.add_child(btn)
		idx +=1

	# Replace with function body.
func _on_level_select(idx):
	print(global.levels[idx])
	selected_level = idx
	update_level_detail()
	$wrap/main.visible = false
	$wrap/levelDetail.visible = true
	
func update_level_detail():
	var records = global.get_records(selected_level)
	var preview = load(thumbnail_path+global.levels[selected_level]["thumbnail"])
	$wrap/levelDetail/containerPrev/preview.set_texture(preview)
	$wrap/levelDetail/levelName.bbcode_text ="[center]"+tr("lvl_name_"+str(selected_level))
	$wrap/levelDetail/records.bbcode_text = records
	
func next_level(pos):
	selected_level +=pos
	if selected_level >=len(global.levels):
		#wrap around
		selected_level = 0
	if selected_level < 0 :
		selected_level = len(global.levels) -1
		while global.levels[selected_level]["playable"] == false:
			selected_level -= 1
	if pos >0 and global.levels[selected_level]["playable"] == false:
		#wrap around
		selected_level = 0
	#update UI
	update_level_detail()



func _on_btnStart_pressed():
	global.current_level = selected_level
	get_tree().change_scene(scene_path+global.levels[selected_level]["scene"])


func _on_btn_back_pressed():
	if $wrap/levelDetail.visible:
		$wrap/main.visible = true
		$wrap/levelDetail.visible = false	
	else:
		emit_signal("back_to_main_menu")


func _on_main_visibility_changed():
	if $wrap/main.visible :
		$wrap/main/levelcenter/levels.get_child(selected_level).grab_focus()
