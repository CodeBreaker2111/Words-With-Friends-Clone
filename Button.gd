extends Button

var dragging = false
var offset = Vector2(0, 0)
var starting_pos
var score = 0
var on_board = false
var board_pos = Vector2.ZERO

func _ready():
	connect("button_down", Callable(self, "_on_button_down"))
	connect("button_up", Callable(self, "_on_button_up"))
	self.add_theme_stylebox_override("normal", StyleBoxEmpty.new()) # Remove default gray texture
	starting_pos = global_position

func _on_button_down():
	print(str(get_global_mouse_position()))
	offset = global_position - get_global_mouse_position()
	dragging = true
	on_board = false

func _on_button_up():
	dragging = false
	snap_tile_to_grid()
	
	self.release_focus()

func _process(delta):
	if dragging:
		global_position = get_global_mouse_position() + offset
	
	if on_board:
		position = grid_to_pos()
		if Board.scale < Vector2(1, 1):
			scale = Vector2(1, 1)
		else:
			scale = Vector2(2, 2)

func get_global_mouse_pos():
	return get_global_mouse_position()

func snap_tile_to_grid(): # uses mouse position
	if Board.scale < Vector2(1, 1):
		scale = Vector2(1, 1)
		position = Board.get_closest_grid_pos(get_global_mouse_pos()) - Vector2(Board.tile_offset_x / 2, Board.tile_offset_y / 2)
		board_pos = Board.get_closest_grid_point(get_global_mouse_pos())
	else:
		scale = Vector2(2, 2)
		position = Board.get_closest_grid_pos(get_global_mouse_pos()) - Vector2(Board.tile_offset_x , Board.tile_offset_y)
		board_pos = Board.get_closest_grid_point(get_global_mouse_pos())
	
	on_board = true

func grid_to_pos() -> Vector2:
	if Board.scale <= Vector2(1, 1):
		return Vector2(board_pos.x * Board.grid_size + Board.grid_offset_x, board_pos.y * Board.grid_size + Board.grid_offset_y) + Board.pos - Vector2(Board.tile_offset_x / 2, Board.tile_offset_y / 2)
	else:
		return Vector2(board_pos.x * Board.grid_size + Board.grid_offset_x, board_pos.y * Board.grid_size + Board.grid_offset_y) + Board.pos - Vector2(Board.tile_offset_x, Board.tile_offset_y)

func changetile(letter):
	$Sprite2D/Letter.text = letter
	
	if letter == "A":
		score = 1
	if letter == "B":
		score = 4
	if letter == "D":
		score = 2
	if letter == "E":
		score = 1
	if letter == "F":
		score = 4
	if letter == "G":
		score = 3
	if letter == "H":
		score = 3
	if letter == "X":
		score = 5
	if letter == "Γ":
		score = 4
	if letter == "Δ":
		score = 3
	if letter == "I":
		score = 1
	if letter == "J":
		score = 10
	if letter == "K":
		score = 5
	if letter == "L":
		score = 2
	if letter == "M":
		score = 4
	if letter == "N":
		score = 2
	if letter == "O":
		score = 2
	if letter == "Π":
		score = 1
	if letter == "P":
		score = 4
	if letter == "Q":
		score = 10
	if letter == "R":
		score = 1
	if letter == "S":
		score = 1
	if letter == "T":
		score = 1
	if letter == "U":
		score = 3
	if letter == "^":
		score = 1
	if letter == "V":
		score = 5
	if letter == "W":
		score = 4
	if letter == "Y":
		score = 3
	if letter == "Z":
		score = 5
	if letter == "'":
		score =  2
	
	if letter == "":
		$Sprite2D/Score.text = ""
	else:
		$Sprite2D/Score.text = str(score)
