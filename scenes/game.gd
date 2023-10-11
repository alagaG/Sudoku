class_name Game
extends Node

var errors : int = 3

const buttons : ButtonGroup = preload('res://sudoku/universal_group.tres')
@onready var error_counter : ErrorCounter = $'%ErrorCounter'
@onready var table : Table = $'%Table'
@onready var difficult_slider : VSlider = $'%Difficult'

enum Modes {
	LEARNING,
	EASY, 
	NORMAL,
	HARD,
	EXTREME
}

func _ready() -> void:
	var bottom_container : HBoxContainer = $'%BottomBtn'
	for child in bottom_container.get_children(): 
		if child is NumberSelector:
			child.connect('button_down', assign_number.bind(child.number))
	
	var reset_btn : Button = $'%ResetBtn'
	reset_btn.connect('button_down', reset)

func assign_number(n:int) -> void:
	var selected_slot = get_selected_btn()
	if selected_slot and not error_counter.is_game_lost():
		var nice_try = selected_slot.try(n)
		
		if not nice_try:
			error_counter.count()

func reset() -> void:
	var mode : Modes = Modes.get(Modes.keys()[difficult_slider.value])
	error_counter.update_mode(mode)
	error_counter.reset()
	table.update_mode(mode)
	table.reset()
	table.generate()

func get_selected_btn() -> NumberSlot:
	return buttons.get_pressed_button()
