class_name NumberSlot
extends Button

var number : int = 0

func try(n:int) -> bool:
	text = str(n)
	if n == number:
		remove_theme_color_override("font_color")
		remove_theme_color_override("font_pressed_color")
		return true
	else:
		add_theme_color_override("font_color", Color.RED)
		add_theme_color_override("font_pressed_color", Color.RED)
		return false

func reveal() -> void:
	text = str(number)

func reset() -> void:
	text = ""
	number = 0
	remove_theme_color_override("font_color")
	remove_theme_color_override("font_pressed_color")

func is_revealed() -> bool:
	return text == str(number)

func is_empty() -> bool:
	return number <= 0
