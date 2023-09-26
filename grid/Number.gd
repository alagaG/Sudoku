class_name NumberSlot
extends Button

var index : int = -1
var value : int = 0

signal selected(slot:NumberSlot)

func _ready():
	connect("button_down", _on_down)

func _on_down():
	emit_signal("selected", self)

func assign(number:int):
	text = str(number)
	value = number
