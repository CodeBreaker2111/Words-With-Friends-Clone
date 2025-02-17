extends Button

var open = false
# Called when the node enters the scene tree for the first time.
func _ready():
	connect("button_down", Callable(self, "_on_button_down"))

func _on_button_down():
	if open:
		open = false
		$background.hide()
		$close.hide()
	else:
		open = true
		$background.show()
		$close.show()
