class_name SidescrollButton
extends Button


enum Directions {
	UP,
	DOWN,
	LEFT,
	RIGHT,
}

@export var direction: Directions


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_up() -> void:
	if not %FarmersMarketCamera.fading_in and not %FarmersMarketCamera.fading_out:
		if direction == Directions.LEFT:
			SignalManager.sidescrolled_left.emit()
		elif direction == Directions.RIGHT:
			SignalManager.sidescrolled_right.emit()
		elif direction == Directions.UP:
			SignalManager.sidescrolled_up.emit()
		elif direction == Directions.DOWN:
			SignalManager.sidescrolled_down.emit()
