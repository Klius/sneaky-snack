extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var MINUTES = 0
var SECONDS = 0
var MILLIS = 0
var time_string = "[i]00:00.[b]00[/b][/i]"
# Called when the node enters the scene tree for the first time.
func _ready():
	#$timer.connect("timeout",self,"countdown")
	$label_timer.bbcode_text = time_string

func _process(delta):
	update_display()
	
func _physics_process(delta):
	add_milliseconds(delta)
	
func add_milliseconds(delta):
	MILLIS += delta
	#print(MILLIS*100)
	if MILLIS>=1:
		SECONDS +=1
		MILLIS = 0
	if SECONDS>=60:
		MINUTES +=1
		SECONDS = 0

func update_display():
	var mins = str(MINUTES)
	var secs = str(SECONDS)
	var millis = str(floor(MILLIS*100))
	if MINUTES < 10:
		mins ="0"+mins
	if SECONDS < 10:
		secs = "0"+secs
	time_string = "[i]"+mins+":"+secs+".[b]"+millis+"[/b][/i]"
	$label_timer.bbcode_text = time_string
	$fps.bbcode_text = "[b]"+str(Engine.get_frames_per_second())+"[/b]"

func get_time_millis():
	var mills = floor(MILLIS*100)
	var secs = SECONDS
	while (secs >= 1):
		mills += 99
		secs -= 1
	return mills


	

	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
