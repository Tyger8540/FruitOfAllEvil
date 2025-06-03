class_name GUI
extends Panel


var lives_left:= 3


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.life_lost.connect(on_life_lost)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$Money.text = "Money: $" + str(Globals.money)
	$Day.text = "Wave: " + str(%WaveManager.cur_wave)


func on_life_lost() -> void:
	if lives_left == 3:
		$Heart3.visible = false
		lives_left -= 1
	elif lives_left == 2:
		$Heart2.visible = false
		lives_left -= 1
	elif lives_left == 1:
		$Heart1.visible = false
		lives_left -= 1
		SignalManager.player_lost.emit()
