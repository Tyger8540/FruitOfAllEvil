class_name GUI
extends Panel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$Money.text = "Money: " + str(Globals.money)
	$Day.text = "Day: " + str(%WaveManager.cur_day)
