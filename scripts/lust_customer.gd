class_name LustCustomer
extends Customer

@export var lover: LustCustomer

var is_completed: bool = false
var customer_manager: CustomerManager


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super(delta)
	if not panel.visible:
		panel.visible = true
		#green_patience_bar.visible = true
		#red_patience_bar.visible = true
		green_patience_timer.start()


func initialize(texture: Texture2D, difficulty_level: int, patience_level: int, patience_time: float, value: int, new_customer_index: int) -> void:
	super(texture, difficulty_level, patience_level, patience_time, value, new_customer_index)


func pause_timers() -> void:
	get_parent().green_patience_timer.stop()
	get_parent().red_patience_timer.stop()


func die() -> void:
	if is_completed and lover.is_completed:
		customer_manager.customer_array.erase(self)
		customer_manager.customer_array.erase(lover)
		customer_manager.customer_pairs.erase(get_parent())
		customer_manager.on_customer_left(0)
		#SignalManager.customer_left.emit(0)
		get_parent().queue_free()
	else:
		get_parent().speed_up_patience_timers()


func _on_green_patience_timer_timeout() -> void:
	pass
