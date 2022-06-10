extends "res://character/Character.gd"

signal moved
signal dead
signal grabbed_key
signal win

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.scale = Vector2(1,1)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if can_move:
		for dir in moves.keys():
			if Input.is_action_pressed(dir):
				if move(dir):
					$Footsteps.play()
					emit_signal('moved')
#	pass

###
# Routine to treat collision with other (Area2D) objects
# It is connected to the area_entered Signal of the player (Area2D) object
# It illustrates several types of collision verification.
###
func _on_Player_area_entered(area):
	if area.is_in_group('enemies'):
		area.hide()
		set_process(false)
		$Lose.play()
		$CollisionShape2D.disabled=true
		$AnimationPlayer.play("die")
		yield($AnimationPlayer, 'animation_finished')
		emit_signal('dead')
	if area.has_method('pickup'):
		area.pickup()
		if area.type == 'RedKey':
			emit_signal('grabbed_key', 'red')
		if area.type == 'GreenKey':
			emit_signal('grabbed_key', 'green')
		if area.type == 'star':
			$Win.play()
			$CollisionShape2D.disabled = true
			yield($Win, "finished")
			emit_signal('win')
	pass # Replace with function body.
