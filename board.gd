extends Node

var pos = Vector2(940, 540) # Temporary position
var scale = Vector2(0.596, 0.596)
var grid_size = 45  # Distance between grid points
var grid_width = 15  # Number of columns
var grid_height = 15  # Number of rows
var tile_offset_x = 40
var tile_offset_y = 48
var grid_offset_x = -325
var grid_offset_y = -329
var tiles_in_use = Array()
var board = Array()
var first_move = true

func get_closest_grid_pos(mouse_pos: Vector2) -> Vector2:
	var closest_point = Vector2.ZERO
	var closest_indices = Vector2.ZERO  # Store grid indices as a Vector2
	var min_distance = INF

	# Loop through the 10x10 grid
	for x in range(Board.grid_width):
		for y in range(Board.grid_height):
			var grid_point = Vector2(x * Board.grid_size + Board.grid_offset_x, y * Board.grid_size + Board.grid_offset_y) + Board.pos  # Apply offset
			var distance = mouse_pos.distance_to(grid_point)  # Calculate distance
			
			if distance < min_distance:
				min_distance = distance
				closest_point = grid_point
				closest_indices = Vector2(x, y)
	
	return closest_point

func get_closest_grid_point(mouse_pos: Vector2) -> Vector2:
	var closest_point = Vector2.ZERO
	var closest_indices = Vector2.ZERO  # Store grid indices as a Vector2
	var min_distance = INF

	# Loop through the 10x10 grid
	for x in range(Board.grid_width):
		for y in range(Board.grid_height):
			var grid_point = Vector2(x * Board.grid_size + Board.grid_offset_x, y * Board.grid_size + Board.grid_offset_y) + Board.pos  # Apply offset
			var distance = mouse_pos.distance_to(grid_point)  # Calculate distance
			
			if distance < min_distance:
				min_distance = distance
				closest_point = grid_point
				closest_indices = Vector2(x, y)
	
	return closest_indices

func check_playable(points: Array) -> bool:
	
	# Section 1 of function: detect if it is first move
	
	if points.size() <= 1:
		return false
	
	var on_star = false
	
	for point in points:
		if point == Vector2(7, 7): # On middle tile
			on_star = true
	
	if !on_star:
		return false
		
	# Section 2 of function: detects straight line
	
	if points.size() == 0:
		return false
	
	var same_x = true
	var same_y = true
	var base_x = points[0].x
	var base_y = points[0].y

	for point in points:
		if point.x != base_x:
			same_x = false
		if point.y != base_y:
			same_y = false
	
	if !same_x and !same_y:
		return false
	
	# Section 3 of function: detect gaps
	# For Future: Make the code for single tile plays
	
	var ordered_axis = Array() # Just the x or y axis of the tiles ordered by number
	
	if same_x:
		for point in points:
			ordered_axis.append(point.y)
	
	elif same_y:
		for point in points:
			ordered_axis.append(point.x)
	
	# Section 3.5 of function: Combine played tiles and words to detect gaps that have already been played
	
	if same_x:
		for tile in Board.board:
			if tile[1].x == points[0].x: # 'tile[1].x' because format of board: [["tile_letter" Vector2(tile_position)]]
				ordered_axis.append(tile[1].x)
	elif same_y:
		for tile in Board.board:
			if tile[1].y == points[0].y: # 'tile[1].x' because format of board: [["tile_letter" Vector2(tile_position)]]
				ordered_axis.append(tile[1].y)
	
	ordered_axis.sort()
	
	for i in range(1, ordered_axis.size()):
		if i != 1:
			if ordered_axis[i] - 1 != ordered_axis[i - 1]:
				return false
		else:
			if ordered_axis[0] + 1 != ordered_axis[1]:
				return false
	
	# Section 4 of function: Fact check words
	return true
