extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$MarginContainer/ScoreLabel.text = str(Global.score)
	pass # Replace with function body.


func update_score(value):
	Global.score += value
	$MarginContainer/ScoreLabel.text = str(Global.score)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
