extends HBoxContainer

func _ready():
	for i in get_child_count():
		var child : Node = get_child(i)
		
		if child is Selector:
			connect("selected", change_number)

func change_number(value:int):
	print(value)
