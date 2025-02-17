extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().get_node("Label").modulate = Color(1, 0, 0)
	connect("button_down", Callable(self, "_on_button_down"))

func _on_button_down():
	if WordList.is_word_in_file(get_parent().get_node("TextEdit").text):
		get_parent().get_node("Label").text = "Valid"
		get_parent().get_node("Label").modulate = Color(0, 1, 0)
	else:
		get_parent().get_node("Label").text = "Invalid"
		get_parent().get_node("Label").modulate = Color(1, 0, 0)
	
	self.release_focus()
