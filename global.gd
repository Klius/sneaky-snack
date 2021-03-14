extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var levels = [
	{
		"name":"Back to basics",
		"tip":"[center]Hide from the guard and grab the fish",
		"thumbnail":"01.png",
		"scene":"level-01.tscn"
	},
	{
		"name":"Clockwise",
		"tip":"[center]All guards patrol in specific ways\nUse them to your advantage!",
		"thumbnail":"02.png",
		"scene":"level-02.tscn"
	},
	{
		"name":"level 3",
		"tip":"",
		"thumbnail":"03.png",
		"scene":"level-03.tscn"
	},
	{"name":"level 4","tip":"","thumbnail":"04.png","scene":"level-04.tscn"},
	{"name":"level 5","tip":"","thumbnail":"05.png","scene":"level-05.tscn"},
	{"name":"level 6","tip":"","thumbnail":"06.png","scene":"level-06.tscn"},
	{"name":"level 7","tip":"","thumbnail":"07.png","scene":"level-07.tscn"},
	{"name":"level 8","tip":"","thumbnail":"08.png","scene":"level-08.tscn"},
	{"name":"level 9","tip":"","thumbnail":"09.png","scene":"level-09.tscn"},
	{"name":"level 10","tip":"","thumbnail":"10.png","scene":"level-10.tscn"},
	{"name":"level 11","tip":"","thumbnail":"11.png","scene":"level-11.tscn"},
	{"name":"level 12","tip":"","thumbnail":"12.png","scene":"level-12.tscn"},
	{"name":"13. Leaking Fountains","tip":"","thumbnail":"12.png","scene":"level-13.tscn"},
	{
		"name":"Test level",
		"tip":"\tTESTTESTESTESTEST jajajaja TESTESTS\n\t2ona linaiaad",
		"thumbnail":"01.png",
		"scene":"test.tscn"
	}
]
var records = [
	[2010,3010,5510],
	[2010,5510,5510],
	[5510,5510,5510],
	[5510,5510,5510],
	[5510,5510,5510],
	[5510,5510,5510],
	[5510,5510,5510],
	[5510,5510,5510],
	[5510,5510,5510],
	[5510,5510,5510],
	[5510,5510,5510],
	[5510,5510,5510],
	[5510,5510,5510],
	[5510,5510,5510],
	[5510,5510,5510],
]
var current_level = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

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
	for record in records[level]:
		rec_str += str(idx)+ " - " + get_record_timestamp(record)+ "\n"
		idx += 1
	return rec_str
	
	
func compare_record(millis):
	pass
	
func register_record(millis):
	var pos = -1
	var idx = 0
	for record in records[current_level]:
		if millis < record:
			pos = idx
			if idx == 0:
				records[current_level][2] = records[current_level][1]
				records[current_level][1] = records[current_level][idx]
			if idx == 1 :
				records[current_level][2] = records[current_level][idx]
			records[current_level][idx] = millis
			break
		idx +=1
	return pos
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
