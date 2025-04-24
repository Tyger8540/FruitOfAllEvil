class_name DefaultCustomer
extends Customer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super(delta)
	if position.x > stand_position.x:
		position.x = move_toward(position.x, stand_position.x, SPEED * delta)
	elif position.x < stand_position.x:
		position = stand_position
	else:
		# set the order panel once the customer reaches their stand_position, if panel not already visible
		if !panel.visible:
			panel.visible = true
			green_patience_bar.visible = true
			red_patience_bar.visible = true
			green_patience_timer.start()
			check_hovering()
			#if $CustomerButton.hovering:
				#$CustomerButton.set_highlight(true)


func initialize(texture: Texture2D, difficulty_level: int, patience_level: int, patience_time: float, value: int, new_customer_index: int) -> void:
	super(texture, difficulty_level, patience_level, patience_time, value, new_customer_index)
	customer_index = new_customer_index
	set_stand_position(customer_index)
