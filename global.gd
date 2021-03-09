extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var levels = [
	{
		"name":"Back to basics",
		"tip":"\tHide from the guard and grab the fish",
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
var current_level = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
