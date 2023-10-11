class_name ErrorCounter
extends HBoxContainer

var max_errors : int = 3
var errors : int = 0

@onready var lives : Array[CheckBox] = [
	$"Life 1", $"Life 2", $"Life 3", $"Life 4", $"Life 5"
]

func update_mode(mode: Game.Modes):
	match mode:
		Game.Modes.LEARNING:
			max_errors = 5
		Game.Modes.EASY:
			max_errors = 4
		Game.Modes.NORMAL:
			max_errors = 4
		Game.Modes.HARD:
			max_errors = 3
		Game.Modes.EXTREME:
			max_errors = 3
	update_lives()

func count() -> void:
	errors += 1
	update_lives()

func update_lives() -> void:
	for i in range(lives.size()):
		var life : CheckBox = lives[i]
		life.button_pressed = max_errors - errors > i
		life.visible = max_errors > i


func reset() -> void:
	errors = 0
	update_lives()

func is_game_lost() -> bool:
	return errors >= max_errors
