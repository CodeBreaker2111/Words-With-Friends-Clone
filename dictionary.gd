extends Node

var words = []

func _ready():
	load_words()

func load_words():
	var file = FileAccess.open("res://dictionaries/alpha/lukiγ/words.txt", FileAccess.READ)
	if file:
		var content = file.get_as_text()
		words = content.split("\n")

func is_word_in_file(word: String) -> bool:
	return word in words
