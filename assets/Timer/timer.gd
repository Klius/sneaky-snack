extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var MINUTES = 0
var SECONDS = 0
var MILLIS = 0
var time_string = "00:00:00"
# Called when the node enters the scene tree for the first time.
func _ready():
	$timer.connect("timeout",self,"countdown")
	$label_timer.text = time_string

func countdown():
	add_milliseconds()
	update_display()

func add_milliseconds():
	MILLIS += 1
	if MILLIS>=99:
		SECONDS +=1
		MILLIS = 0
	if SECONDS>=60:
		MINUTES +=1
		SECONDS = 0

func update_display():
	var mins = str(MINUTES)
	var secs = str(SECONDS)
	var millis = str(MILLIS)
	if MINUTES < 10:
		mins ="0"+mins
	if SECONDS < 10:
		secs = "0"+secs
	time_string = "[i]"+mins+":"+secs+".[b]"+millis+"[/b][/i]"
	$label_timer.bbcode_text = time_string
	
func stop():
	$timer.stop()
	
func start():
	$timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
