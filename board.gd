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

