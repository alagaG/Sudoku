class_name Selector
extends Button

@export
var number : int = 0 : set = _set_number

signal selected(number:int)

func _ready():
	connect("button_down", _emit_selected)

func _set_number(value:int):
	number = value
	text = str(value)
	name = "Selector - {number}".format({ "number": number })

func _emit_selected():
	emit_signal("selected", number)
