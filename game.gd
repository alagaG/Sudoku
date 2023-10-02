extends Node

var selected_slot : NumberSlot = null

func _ready():
	var table = $VDividor/Center/Table
	for grid in table.get_children():
		grid.connect("slot_selected", select_slot)
	
	var buttons = $VDividor/Buttons/Selectors
	for btn in buttons.get_children():
		if btn is Selector:
			btn.connect("selected", assign_number)

func select_slot(slot:NumberSlot):
	selected_slot = slot

func assign_number(number:int):
	if selected_slot:
		selected_slot as NumberSlot
		selected_slot.assign(number)
