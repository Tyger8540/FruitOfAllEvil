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
		green_patience_bar.visible = true
		red_patience_bar.visible = true
		green_patience_timer.start()


func initialize(texture: Texture2D, difficulty_level: int, patience_level: int, patience_time: float, value: int, new_customer_index: int) -> void:
	super(texture, difficulty_level, patience_level, patience_time, value, new_customer_index)


func die() -> void:
	if lover.is_completed:
		customer_manager.customer_array.erase(self)
		customer_manager.customer_array.erase(lover)
		customer_manager.customer_pairs.erase(get_parent())
		get_parent().queue_free()
	else:
		is_completed = true
