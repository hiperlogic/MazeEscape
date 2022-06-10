extends Area2D

signal coin_pickup

###
# Instead of creating several inherited items and set the sprites individually
# use a dict to speed the process
#
###
var textures = {
	'coin': 'res://assets/coin.png',
	'RedKey': 'res://assets/keyRed.png',
	'GreenKey': 'res://assets/keyGreen.png',
	'star': 'res://assets/star.png'
}

var type

# Called when the node enters the scene tree for the first time.
func _ready():
	$Tween.interpolate_property($Sprite, 'scale', Vector2(1,1),
								Vector2(3,3), 0.5, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	$Tween.interpolate_property($Sprite, 'modulate', Color(1,1,1,1),
								Color(1,1,1,0), 0.5, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)

###
# Init the object according to type
#
###
func init(_type, pos):
	$Sprite.texture = load(textures[_type])
	type = _type
	position = pos
	
func pickup():
	match type:
		'coin':
			emit_signal('coin_pickup', 1)
			$CoinPickup.play()
		'RedKey':
			$KeyPickup.play()
			print_debug("Red Key Picked")
		'GreenKey':
			$KeyPickup.play()
			print_debug("Red Key Picked")
	print_debug("before disabled")
	$CollisionShape2D.disabled = true
	$Tween.start()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

###
# Connect the tween_completed signal
# Frees the pickup object
###
func _on_Tween_tween_completed(object, key):
	print_debug("before delete")
	queue_free()
	pass # Replace with function body.
