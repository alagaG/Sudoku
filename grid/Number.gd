class_name Number
extends Button

var grid_x : int = 0
var grid_y : int = 0

func _ready():
	name = "Number - {x}, {y}".format({ "x": grid_x, "y": grid_y})
