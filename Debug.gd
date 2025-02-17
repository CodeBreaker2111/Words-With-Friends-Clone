extends Node

var showing = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$Size.hide()
	$Offset.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Size.text = "Tile Spacing: " + str(Board.grid_size)
	$Offset.text = "Grid Offset: " + str(Board.grid_offset_x) + ", " + str(Board.grid_offset_y)
	
	if Input.is_action_just_pressed("Debug"):
		if showing:
			$Size.hide()
			$Offset.hide()
			showing = false
		else:
			$Size.show()
			$Offset.show()
			showing = true
	
	if Input.is_action_just_pressed("num1"):
		Board.grid_size += 0.5
	
	if Input.is_action_just_pressed("num4"):
		Board.grid_offset_x += 0.5
	
	if Input.is_action_just_pressed("num7"):
		Board.grid_offset_y += 0.5
	
	if Input.is_action_just_pressed("num2"):
		Board.grid_size -= 0.5
	
	if Input.is_action_just_pressed("num5"):
		Board.grid_offset_x -= 0.5
	
	if Input.is_action_just_pressed("num8"):
		Board.grid_offset_y -= 0.5
