class_name CharonCustomer
extends Customer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super(delta)
	if !panel.visible:
		panel.visible = true
		green_patience_bar.visible = true
		red_patience_bar.visible = true
		green_patience_timer.start()


# Don't really need this since it just calls its parent's functionality
func initialize(texture: Texture2D, difficulty_level: int, patience_level: int, patience_time: float, value: int, new_customer_index: int) -> void:
	super(texture, difficulty_level, patience_level, patience_time, value, new_customer_index)


func die() -> void:
	SignalManager.charon_customer_finished.emit(self)
	#queue_free()
	
