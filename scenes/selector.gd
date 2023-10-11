class_name NumberSelector
extends Button

@export
var number : int = 0 : set = set_number

func set_number(value:int):
	number = value
	text = str(value)
	name = "Selector - {number}".format({ "number": number })

