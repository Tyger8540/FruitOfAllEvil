class_name TrashButton
extends Button

var hovering:= false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_button_up() -> void:
	# Only complete a button press if the player is hovering the button when released
	# Fixes the issue of trying to click and drag
	if hovering:
		SignalManager.grabbable_placed.emit()


func _on_mouse_entered() -> void:
	hovering = true


func _on_mouse_exited() -> void:
	hovering = false
