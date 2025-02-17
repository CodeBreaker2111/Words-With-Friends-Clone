extends Button

var dragging = false

func _ready():
	connect("button_down", Callable(self, "_on_button_down"))
	connect("button_up", Callable(self, "_on_button_up"))
func _on_button_down():
	dragging = true

func _on_button_up():
	dragging = false

func _process(delta):
	if dragging:
		global_position = get_global_mouse_position()
