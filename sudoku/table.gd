class_name Table
extends GridContainer

var slot_matrix : Array[Array] = [[], [], [], [], [], [], [], [], []]
var generating : bool = true
var revealing_numbers : int = 30

func _ready() -> void:
	for grid_idx in get_child_count():
		var grid : GridContainer = get_child(grid_idx)
		for slot_idx in grid.get_child_count():
			var slot : NumberSlot = grid.get_child(slot_idx)
			var pos : int = (grid_idx % 3) * 3 + (slot_idx % 3)
			slot_matrix[pos].push_back(slot)
	generate()

func update_mode(mode:Game.Modes) -> void:
	var diff : float = 1.0
	match mode:
		Game.Modes.LEARNING:
			diff = 5
		Game.Modes.EASY:
			diff = 4
		Game.Modes.NORMAL:
			diff = 3.0
		Game.Modes.HARD:
			diff = 2.25
		Game.Modes.EXTREME:
			diff = 1.75
	revealing_numbers = 9 * diff

func generate() -> void:
	_generate_box(Vector2i(0, 0))
	_generate_box(Vector2i(1, 1))
	_generate_box(Vector2i(2, 2))
	_generate_remaining(Vector2i.ZERO)
	reveal(revealing_numbers)

func reveal(qtd:int) -> void:
	var count = qtd
	while count > 0:
		var slot : NumberSlot = slot_matrix[randi_range(0, 8)][randi_range(0, 8)]
		if not slot.is_revealed():
			slot.reveal()
			count -= 1

func _generate_box(pos:Vector2i) -> void:
	var numbers = range(1, 10)
	numbers.shuffle()
	pos *= 3
	for x in range(3):
		for y in range(3):
			var npos = pos + Vector2i(x, y)
			for n in numbers:
				if is_valid_for(npos, n): 
					slot_matrix[npos.x][npos.y].number = n

func _generate_remaining(pos:Vector2i) -> bool:
	if pos.x == 9 and pos.y == 8:
		return true

	if pos.x == 9:
		pos.x = 0
		pos.y += 1
	
	if slot_matrix[pos.x][pos.y].number != 0:
		return _generate_remaining(pos + Vector2i.RIGHT)
	
	for n in range(1, 10):
		if is_valid_for(pos, n):
			slot_matrix[pos.x][pos.y].number = n
			if _generate_remaining(pos + Vector2i.RIGHT):
				return true
			slot_matrix[pos.x][pos.y].number = 0
	return false

func reset() -> void:
	for col in slot_matrix:
		for slot in col:
			slot.reset()

func is_filled() -> bool:
	for col in slot_matrix:
		for slot in col:
			if not slot.is_revealed(): return false
	return true

func is_generated() -> bool:
	for col in slot_matrix:
		for slot in col:
			if slot.number == 0: return false
	return true

func is_valid_for(pos:Vector2i, n:int) -> bool:
	return not (col_contains(pos, n) or row_contains(pos, n) or box_contains(pos, n))

func box_contains(pos:Vector2i, n:int) -> bool:
	var box_pos : Vector2i = (pos / 3) * 3
	for x in range(3):
		for y in range(3):
			if slot_matrix[x + box_pos.x][y + box_pos.y].number == n: return true
	return false

func row_contains(pos:Vector2i, n:int) -> bool:
	for i in range(9):
		if slot_matrix[i][pos.y].number == n: return true
	return false

func col_contains(pos:Vector2i, n:int) -> bool:
	for slot in slot_matrix[pos.x]:
		if slot.number == n: return true
	return false
