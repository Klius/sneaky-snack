extends Control

var levels = [
	{"name":"Back to basics","thumbnail":"01.png","scene":"level-01.tscn"},
	{"name":"level 2","thumbnail":"02.png","scene":"level-02.tscn"},
	{"name":"level 3","thumbnail":"03.png","scene":"level-03.tscn"},
	{"name":"level 4","thumbnail":"04.png","scene":"level-04.tscn"},
	{"name":"level 5","thumbnail":"05.png","scene":"level-05.tscn"},
	{"name":"level 6","thumbnail":"06.png","scene":"level-06.tscn"},
	{"name":"level 7","thumbnail":"07.png","scene":"level-07.tscn"},
	{"name":"level 8","thumbnail":"08.png","scene":"level-08.tscn"},
	{"name":"level 9","thumbnail":"09.png","scene":"level-09.tscn"},
	{"name":"level 10","thumbnail":"10.png","scene":"level-10.tscn"},
	{"name":"level 11","thumbnail":"11.png","scene":"level-11.tscn"},
	{"name":"level 12","thumbnail":"12.png","scene":"level-12.tscn"}
	]
signal back_to_main_menu
var thumbnail_path = "res://assets/level_thumbnails/"
var scene_path = "res://assets/level/"
var selected_level = 0
var button = "res://assets/button/button.tscn"
# Called when the node enters the scene tree for the first time.
func _ready():
	var gridLevels = $wrap/main/levelcenter/levels
	var idx = 0
	for level in levels:
		var btn = load(button).instance()
		btn.set_text(str(idx+1))
		btn.size_flags_vertical = SIZE_EXPAND_FILL
		btn.connect("pressed",self,"_on_level_select",[idx])
		gridLevels.add_child(btn)
		idx +=1

	# Replace with function body.
func _on_level_select(idx):
	print(levels[idx])
	selected_level = idx
	update_level_detail()
	$wrap/main.visible = false
	$wrap/levelDetail.visible = true
	
func update_level_detail():
	var preview = load(thumbnail_path+levels[selected_level]["thumbnail"])
	$wrap/levelDetail/containerPrev/preview.set_texture(preview)
	$wrap/levelDetail/levelName.bbcode_text ="[center]"+levels[selected_level]["name"]

	
func next_level(pos):
	selected_level +=pos
	if selected_level >=len(levels):
		#wrap around
		selected_level = 0
	if selected_level < 0 :
		selected_level = len(levels) -1
	#update UI
	update_level_detail()



func _on_btnStart_pressed():
	get_tree().change_scene(scene_path+levels[selected_level]["scene"])


func _on_btn_back_pressed():
	if $wrap/levelDetail.visible:
		$wrap/main.visible = true
		$wrap/levelDetail.visible = false	
	else:
		emit_signal("back_to_main_menu")


func _on_main_visibility_changed():
	if $wrap/main.visible :
		$wrap/main/levelcenter/levels.get_child(selected_level).grab_focus()
