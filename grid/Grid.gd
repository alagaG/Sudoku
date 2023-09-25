extends GridContainer

const NumberScene : PackedScene = preload("res://grid/Number.tscn")

func _ready():
	for i in range(9):
		for j in range(9):
			var child = NumberScene.instantiate()
			child.grid_x = j
			child.grid_y = i
			add_child(child)
