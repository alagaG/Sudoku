extends GridContainer

var _matrix : Array = []
var generating : bool = true

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
	_generate_table()

func _matrix_create(slots:Array):
	slots.sort_custom(func(a:NumberSlot, b:NumberSlot):
		return b.index > a.index
	)
	
	var matrix : Array = [[], [], [], [], [], [], [], [], []]
	for slot in slots:
		slot as NumberSlot
		slot.assign(0)
		matrix[slot.index % 9].push_back(slot)
	return matrix

func _process(delta:float):
	if generating:
		_generate_table()	

func _clear():
	for y in range(9):
		for x in range(9):
			_matrix[x][y].assign(0)

func _generate_table():
	_clear()
	_generate_grid(0)
	_generate_grid(2)
	_generate_grid(6)
	_generate_grid(8)
	var numbers = [ 1, 2, 3, 4, 5, 6, 7, 8, 9 ]
	numbers.shuffle()

	for count in range(50):
		numbers.shuffle()
		randomize()
		for y in range(9):
			for x in range(9):
				var slot = _matrix[x][y]
				var pos = Vector2i(x, y)
				for n in numbers:
					if not grid_contains(pos, n) and not intersec_contains(pos, n):
						slot.assign(n)
		if is_full():
			print("End")
			generating = false
			break

func _check_grid(grid_idx:int):
	for y in range(3):
		for x in range(3):
			if _matrix[x + (grid_idx % 3 * 3)][y + (floor(grid_idx / 3) * 3)].is_empty():
				return false
	return true

func _generate_grid(grid_idx:int):
	var numbers = [ 1, 2, 3, 4, 5, 6, 7, 8, 9 ]
	for y in range(3):
		for x in range(3):
			var pos = Vector2i(x + (grid_idx % 3 * 3), y + (floor(grid_idx / 3) * 3))
			for n in numbers:
				if not grid_contains(pos, n) and not intersec_contains(pos, n):
					_matrix[pos.x][pos.y].assign(n)
			numbers.shuffle()

func is_full() -> bool:
	for i in range(81):
		if _matrix[i%9][floor(i/9)].is_empty():
			return false
	return true

func grid_contains(pos:Vector2i, value:int) -> bool:
	var grid_pos = pos / 3
	for i in range(3):
		for j in range(3):
			var slot = _matrix[grid_pos.x * 3 + j][grid_pos.y * 3 + i]
			if slot.value == value:
				return true
	return false

func intersec_contains(pos:Vector2i, value:int) -> bool:
	var checkers = _matrix[pos.x].duplicate()
	for i in range(9):
		checkers.push_back(_matrix[i][pos.y])
	
	for slot in checkers:
		slot as NumberSlot
		if slot.value == value:
			return true
	return false
