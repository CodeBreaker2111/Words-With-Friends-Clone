extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	$Tile1.changetile("K")
	$Tile2.changetile("A")
	$Tile3.changetile("'")
	$Tile4.changetile("X")
	$Tile5.changetile("^")
	$Tile6.changetile("Γ")
	$Tile7.changetile("Δ")
	print(str($Tile1.global_position))
