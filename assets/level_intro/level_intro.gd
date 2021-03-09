extends Control


signal start_level
var global

# Called when the node enters the scene tree for the first time.
func _ready():
	global = get_node("/root/global")
	set_text(global.levels[global.current_level])

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_btnstart_pressed():
	emit_signal("start_level")
	self.visible = false

func set_text(level):
	$vbox/title.set_bbcode("[center]"+level.name)
	$vbox/tip.set_bbcode(level.tip)
