extends Node


var levels = ['res://level/Level1.tscn', 
			  'res://level/Level2.tscn']
var current_level
var score

var highscore = 0
var score_file = "user://highscore.txt"

var start_screen = 'res://start_screen/StartScreen.tscn'
var end_screen = 'res://end_screen/EndScreen.tscn'

func new_game():
	score = 0
	current_level = -1
	next_level()
	
func game_over():
	if score > highscore:
		highscore = score
		save_score()
	get_tree().change_scene(end_screen)

func save_score():
	var f = File.new()
	f.open(score_file, File.WRITE)
	f.store_string(str(highscore))
	f.close()
	
func next_level():
	current_level+=1
	if current_level >= Global.levels.size():
		# no more levels to load
		game_over()
	else:
		get_tree().change_scene(levels[current_level])

# Called when the node enters the scene tree for the first time.
func _ready():
	setup()
	pass # Replace with function body.

func setup():
	var f = File.new()
	highscore = 0
	if f.file_exists(score_file):
		f.open(score_file, File.READ)
		var content = f.get_as_text()
		highscore = int(content)
		f.close()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
