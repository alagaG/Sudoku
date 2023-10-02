class_name Grid
extends GridContainer

const NumberScene : PackedScene = preload("res://grid/number.tscn")
var pos : Vector2 = Vector2.ZERO

signal slot_selected(slot:NumberSlot)

func initialize():
	for idx in get_child_count():
		var child = get_child(idx) as NumberSlot
		var child_x = idx % 3
		var child_y = floor(idx / 3) * 9
		child.index = (pos.x * 3) + (pos.y * 27) + child_x + child_y
		child.name = "Number-{0}".format([child.index])
		child.connect("selected", request_selection)

func request_selection(slot:NumberSlot):
	emit_signal("slot_selected", slot)
