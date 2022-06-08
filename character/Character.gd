extends Area2D

export (int) var speed

var tile_size = 64
var can_move = true
var facing = 'right'
var moves = {
	'right': Vector2(1,0),
	'left': Vector2(-1,0),
	'up': Vector2(0,-1),
	'down': Vector2(0,1),
}

# Onready is a syntactic sugar to data assignment on the _ready routine
onready var raycasts = {
	'right': $RayCastRight,
	'left': $RayCastLeft,
	'up': $RayCastUp,
	'down': $RayCastDown
}

###
# Function to move the character in the direction if raycasts do not collide
# Animates using tween
###
func move(dir):
	$AnimationPlayer.playback_speed = speed
	facing = dir
	if raycasts[facing].is_colliding():
		return
	can_move = false
	$AnimationPlayer.play(facing)
	$MoveTween.interpolate_property(self, "position", position,
									position + moves[facing]*tile_size, 1.0/speed,
									Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	$MoveTween.start()
	return true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

###
# Routine to re-enable the character to move (after animation ends)
# This is called when the tween completes its function.
# it is connected to the tween_completed signal of the MoveTween object
###
func _on_MoveTween_tween_completed(object, key):
	can_move = true
	pass # Replace with function body.
