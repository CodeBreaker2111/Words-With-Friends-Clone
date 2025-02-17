extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("button_down", Callable(self, "_on_button_down"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_button_down(): # close everything
	get_parent()._on_button_down() # close dictionary
	get_parent().get_parent()._on_button_down() # close more menu
