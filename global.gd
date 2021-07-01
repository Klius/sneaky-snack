extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var levels = {
	"easy":[
		{"thumbnail":"01.png","scene":"level-01.tscn","playable":true,"records":[2010,3010,5510]},
		{"thumbnail":"02.png","scene":"level-02.tscn","playable": true,"records":[2010,3010,5510]},
		{"thumbnail":"03.png","scene":"level-03.tscn","playable": true,"records":[2010,3010,5510]},
		{"playable": false,"thumbnail":"04.png","scene":"level-04.tscn","records":[2010,3010,5510]},
		{"playable": false,"thumbnail":"05.png","scene":"level-05.tscn","records":[2010,3010,5510]},
		{"playable": false,"thumbnail":"06.png","scene":"level-06.tscn","records":[2010,3010,5510]},
		{"playable": false,"thumbnail":"07.png","scene":"level-07.tscn","records":[2010,3010,5510]},
		{"playable": false,"thumbnail":"08.png","scene":"level-08.tscn","records":[2010,3010,5510]},
		{"playable": false,"thumbnail":"09.png","scene":"level-09.tscn","records":[2010,3010,5510]},
		{"playable": false,"thumbnail":"10.png","scene":"level-10.tscn","records":[2010,3010,5510]},
		{"playable": false,"thumbnail":"11.png","scene":"level-11.tscn","records":[2010,3010,5510]},
		{"playable": false,"thumbnail":"12.png","scene":"level-12.tscn","records":[2010,3010,5510]},
		{"playable": false,"thumbnail":"12.png","scene":"level-13.tscn","records":[2010,3010,5510]},
		{"playable": false,"thumbnail":"12.png","scene":"level-14.tscn","records":[2010,3010,5510]},
		{"playable": false,"thumbnail":"12.png","scene":"level-15.tscn","records":[2010,3010,5510]},
		{"playable": true, "thumbnail":"01.png", "scene":"test.tscn","records":[2010,3010,5510]},
		{"playable": false,"thumbnail":"12.png","scene":"end.tscn"}
	],
	"medium":[
		{"playable": true,"thumbnail":"12.png","scene":"level-14.tscn","records":[2010,3010,5510]},
		{"playable": false,"thumbnail":"12.png","scene":"end.tscn"}
	],
	"hard":[
		{"playable": true, "thumbnail":"01.png", "scene":"test.tscn","records":[2010,3010,5510]},
		{"playable": false,"thumbnail":"12.png","scene":"end.tscn"}
	]
}

var current_level = 0
var current_difficulty = "easy"
# Called when the node enters the scene tree for the first time.
func _ready():
	load_data()
#	pass
func get_record_timestamp(millis):
	var secs = 0
	var mins = 0
	while (millis>=99):
		secs += 1
		millis -= 99
		if secs >= 60:
			mins +=1
			secs = 0
	var str_mins = "0"
	var str_secs = "0"
	var str_millis = "0"
	if mins < 10:
		str_mins += str(mins) 
	else:
		str_mins = str(mins)
	if secs < 10:
		str_secs += str(secs)
	else:
		str_secs = str(secs)
	if millis < 10:
		str_millis += str(millis) 
	else:
		str_millis = str(millis)
	return "[i]"+str_mins+":"+str_secs+".[b]"+str_millis+"[/b][/i]"

func get_records(level=0):
	var rec_str = "[center]"
	var idx = 1
	var records = levels[current_difficulty][level]["records"]
	for record in records:
		rec_str += str(idx)+ " - " + get_record_timestamp(record)+ "\n"
		idx += 1
	return rec_str
	
	
func compare_record(millis):
	pass
	
func register_record(millis):
	var pos = -1
	var idx = 0
	var records = levels[current_difficulty][current_level]["records"]
	for record in records:
		if millis < record:
			pos = idx
			if idx == 0:
				records[2] = records[1]
				records[1] = records[idx]
			if idx == 1 :
				records[2] = records[idx]
			records[idx] = millis
			break
		idx +=1
	return pos
	
func get_audio_level(bus_name):
	var level = AudioServer.get_bus_volume_db(AudioServer.get_bus_index(bus_name))
	return str(level)
### TODO save audio levels
func save_config():
	var music = get_audio_level("music")
	var sfx = get_audio_level("sfx")
	var save_data = {
		"levels":levels,
		"locale": TranslationServer.get_locale(),
		"music":music,
		"sfx":sfx
	}
	var save_game = File.new()
	save_game.open("user://savegame.save", File.WRITE)
	save_game.store_line(to_json(save_data))
	save_game.close()

func unlock_next_level():
	if len(levels[current_difficulty]) < current_level:
		levels[current_level]["playable"] = true
		global.save_config()

func load_data():
	var save_game = File.new()
	if not save_game.file_exists("user://savegame.save"):
		return # Error! We don't have a save to load.
	save_game.open("user://savegame.save",File.READ)
	var saved_data = parse_json(save_game.get_line())
	levels = saved_data["levels"]
	TranslationServer.set_locale(saved_data["locale"])
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("music"),float(saved_data["music"]))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("sfx"),float(saved_data["sfx"]))
	save_game.close()
