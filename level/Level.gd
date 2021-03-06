extends Node2D

export (PackedScene) var Enemy
export (PackedScene) var Pickup

onready var items = $Items
var redDoors = []
var greenDoors = []



# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	$Items.hide()
	set_camera_limits()
	var red_door_id = $Walls.tile_set.find_tile_by_name('RedDoor')
	for cell in $Walls.get_used_cells_by_id(red_door_id):
		redDoors.append(cell)
	var green_door_id = $Walls.tile_set.find_tile_by_name('GreenDoor')
	for cell in $Walls.get_used_cells_by_id(green_door_id):
		greenDoors.append(cell)
	spawn_items()
	# Connect the player signals to slots in the self object
	$Player.connect('dead', self, 'game_over')
	$Player.connect('grabbed_key', self, '_on_Player_grabbed_key')
	$Player.connect('win', self, '_on_Player_win')
	pass # Replace with function body.


func set_camera_limits():
	var map_size = $Ground.get_used_rect()
	var cell_size = $Ground.cell_size
	$Player/Camera2D.limit_left = map_size.position.x*cell_size.x
	$Player/Camera2D.limit_top= map_size.position.y*cell_size.y
	$Player/Camera2D.limit_right = map_size.end.x*cell_size.x
	$Player/Camera2D.limit_bottom = map_size.end.y*cell_size.y
	
	
func spawn_items():
	for cell in items.get_used_cells():
		var id = items.get_cellv(cell)
		var type = items.tile_set.tile_get_name(id)
		var pos = items.map_to_world(cell) + items.cell_size/2
		match type:
			'GreenDotDark':
				var s = Enemy.instance()
				s.position = pos
				s.tile_size = items.cell_size
				add_child(s)
			'RedDotDark':
				$Player.position = pos
				$Player.tile_size = items.cell_size
			'coin', 'RedKey', 'GreenKey','star':
				var p = Pickup.instance()
				p.init(type, pos)
				add_child(p)
				p.connect('coin_pickup', $HUD, 'update_score')
func game_over():
	Global.game_over()
		
func _on_Player_win():
	Global.next_level()
	
func _on_Player_grabbed_key(keyColor):
	match keyColor:
		'red':
			for cell in redDoors:
				print("Release Doors")
				$Walls.set_cellv(cell, -1)
		'green':
			for cell in greenDoors:
				print("Release Doors")
				$Walls.set_cellv(cell, -1)
			
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
