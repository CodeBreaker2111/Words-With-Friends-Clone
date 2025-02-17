extends Button

var open = false
# Called when the node enters the scene tree for the first time.
func _ready():
	connect("button_down", Callable(self, "_on_button_down"))

func _on_button_down():
	if open:
		open = false
		$More.show()
		$Less.hide()
		$Dictionary.hide()
		$Dots.rotation = 0
	else:
		open = true
		$More.hide()
		$Less.show()
		$Dictionary.show()
		$Dots.rotation = 1.5708
	
	self.release_focus()
