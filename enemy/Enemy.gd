extends "res://character/Character.gd"


# Called when the node enters the scene tree for the first time.
###
# moves and call the timer to animate. After that (timeout) re-enable move
#
###
func _ready():
	can_move = false
	facing = moves.keys()[randi()%4]
	# Create a one timer function on the tree to let things in the set be ready
	# This relieves us to create a timer object for one specific use!
	yield(get_tree().create_timer(0.5), 'timeout')
	can_move = true


# Called every frame. 'delta' is the elapsed time since the previous frame
###
# if can move, try and move. if cannot move in the direction, reset the direction to move
# randomly it can change direction
#
# Note: If the code was in another function that would be called in a response to the
#       player's move signal, it would transform the game in a turn based.
#
#
###
func _process(delta):
	# this variable can be set to the object in order to serve to the game difficulty later
	var change_dir_perc = 5 # 0 - 9
	if can_move:
		if not move(facing) or randi()%10>change_dir_perc: # this gives a 50% chance change direction
			# could not move (wall) or the direction changed
			facing = moves.keys()[randi()%4]

