extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var LOCALES = []
signal settings_to_main_menu
# Called when the node enters the scene tree for the first time.
func _ready():
	var locale_idx = 0
	for locale in LOCALES:
		if locale == TranslationServer.get_locale():
			break
		locale_idx += 1
	$menu/c_lang/btn_lang.selected = locale_idx


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_btn_lang_item_selected(index):
	TranslationServer.set_locale(LOCALES[index])


func _on_play_audio(name):
	var audioplayer = get_node("audios/"+name.to_lower())
	if audioplayer.is_playing() == false:
		audioplayer.play()
		


func _on_stop_audio(name):
	var audioplayer = get_node("audios/"+name.to_lower())
	audioplayer.stop()


func _on_btn_back_pressed():
	global.save_config()
	emit_signal("settings_to_main_menu")
