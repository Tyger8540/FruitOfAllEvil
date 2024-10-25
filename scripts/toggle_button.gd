class_name ToggleButton
extends Button


var button_toggled: bool

func _process(_delta: float):
	pass

func _on_toggled(toggled_on: bool) -> void:
	button_toggled = toggled_on
	if toggled_on:
		text = "I am toggled"
	else:
		text = "I am not toggled"
