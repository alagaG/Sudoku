extends GridContainer

var _matrix : Array = []

func _ready():
	var slots : Array = []
	for idx in get_child_count():
		var grid = get_child(idx)
		grid as Grid
		grid.pos = Vector2(idx % 3, floor(idx / 3)) 
		grid.name = "Grid-{0}".format([grid.pos])
		grid.initialize()
		for slot in grid.get_children():
			slots.push_back(slot)
	_matrix = _matrix_create(slots)
	generate_table()

func _matrix_create(slots:Array):
	slots.sort_custom(func(a:NumberSlot, b:NumberSlot):
		return b.index > a.index
	)
	
	var matrix : Array = [[], [], [], [], [], [], [], [], []]
	for slot in slots:
		slot as NumberSlot
		matrix[slot.index % 9].push_back(slot)
	return matrix

func generate_table():
	for child_idx in get_child_count():
		var grid = get_child(child_idx) as Grid
		grid.generate()
	
	print(intersec_contains(Vector2(1, 1), 2))

func grid_contains(pos:Vector2, value:int):
	var grid_pos = (pos / 3).floor()
	var tester_idx = _matrix[pos.x][pos.y].index
	for i in range(3):
		for j in range(3):
			var slot = _matrix[grid_pos.x * 3 + j][grid_pos.y * 3 + i]
			if slot.index != tester_idx:
				if slot.value == value:
					return true
	return false

func intersec_contains(pos, value):
	var tester_idx = _matrix[pos.x][pos.y].index
	var checkers = _matrix[pos.x].duplicate()
	for i in range(9):
		checkers.push_back(_matrix[i][pos.y])
	
	for slot in checkers:
		slot as NumberSlot
		if slot.index != tester_idx:
			if slot.value == value:
				return true
	return false
