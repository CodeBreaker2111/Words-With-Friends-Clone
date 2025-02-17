extends Sprite2D

var zoom = false

func _ready():
	print("Board global position: ", str(global_position))
	Board.pos = global_position

func _process(delta):
	if Input.is_action_just_pressed("space_bar"):
		if zoom:
			position = Vector2(0, 0)
			scale = Vector2(0.596, 0.596)
			Board.scale = Vector2(0.596, 0.596)
			Board.pos = global_position
			Board.grid_size = 45
			Board.tile_offset_x = 20
			Board.tile_offset_y = 24
			Board.grid_offset_x = -325
			Board.grid_offset_y = -329
			zoom = false
		elif !zoom:
			scale = Vector2(1.192, 1.192)
			Board.scale = Vector2(1.192, 1.192)
			Board.grid_size = 90
			Board.tile_offset_x = 40
			Board.tile_offset_y = 51
			Board.grid_offset_x = -630
			Board.grid_offset_y = -630
			zoom = true
	
	if Input.is_action_pressed("left"):
		if zoom and position.x > -697.32 / 2:
			position.x -= 15
			Board.pos = global_position
	
	if Input.is_action_pressed("right"):
		if zoom and position.x < 697.32 / 2:
			position.x += 15
			Board.pos = global_position
	
	if Input.is_action_pressed("up"):
		if zoom and position.y > -697.32 / 2:
			position.y -= 15
			Board.pos = global_position
	
	if Input.is_action_pressed("down"):
		if zoom and position.y < 697.32 / 2:
			position.y += 15
			Board.pos = global_position
