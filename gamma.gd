extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("button_down", Callable(self, "_on_button_down"))

func _on_button_down():
	get_parent().get_node("TextEdit").text += "γ"
