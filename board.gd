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

# Returns true if the array "points" (an Array of Vector2) forms a contiguous straight line.
func points_in_line(points: Array) -> bool:
	# If there are 0 or 1 points, we consider that a (trivial) line.
	if points.size() <= 1:
		return true

	# Determine the base direction.
	var base = points[0]
	var diff = points[1] - base

	# Normalize diff to get the unit step in each direction.
	# (For example, if diff is (3,0) we want the step to be (1,0); if diff is (-2, -2) we want (-1,-1))
	var step = Vector2.ZERO
	if diff.x != 0:
		step.x = sign(diff.x)
	if diff.y != 0:
		step.y = sign(diff.y)
	
	# Check that all points are collinear with the base.
	# For grid-based points, a quick test is to see if the vector from the base to each point 
	# is a multiple of our step vector.
	for i in range(1, points.size()):
		var delta = points[i] - base
		# For each coordinate where step is nonzero, delta must be an integer multiple of step.
		if step.x != 0:
			if int(delta.x) % int(step.x) != 0:
				return false
		if step.y != 0:
			if int(delta.y) % int(step.y) != 0:
				return false
		# Also, the ratio for x and y (if both nonzero) must be the same.
		if step.x != 0 and step.y != 0:
			var factor_x = delta.x / step.x
			var factor_y = delta.y / step.y
			if factor_x != factor_y:
				return false
	# At this point, we know the points lie along the same infinite line.
	
	# Now check that the points are contiguous (with no gaps).
	# To do so, sort the points along the direction of the line.
	# For horizontal lines or diagonals we can sort by x; for vertical lines, sort by y.
	var sorted_points = points.duplicate()
	if step.x != 0:
		sorted_points.sort_custom(Callable(self, "_compare_by_x_then_y"))
	else:
		sorted_points.sort_custom(Callable(self, "_compare_by_y_then_x"))
	
	# Now check that each adjacent pair is exactly one step apart.
	for i in range(sorted_points.size() - 1):
		var expected = sorted_points[i] + step
		if sorted_points[i+1] != expected:
			return false
	return true

# Helper for sorting by x then y (suitable for non-vertical lines)
func _compare_by_x_then_y(a, b):
	if a.x == b.x:
		return int(a.y - b.y)
	return int(a.x - b.x)

# Helper for sorting by y then x (suitable for vertical lines)
func _compare_by_y_then_x(a, b):
	if a.y == b.y:
		return int(a.x - b.x)
	return int(a.y - b.y)
