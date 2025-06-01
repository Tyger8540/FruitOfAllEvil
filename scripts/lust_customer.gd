class_name LustCustomer
extends Customer

@export var lover: LustCustomer
@export var customer_button: LustCustomerButton

var is_completed: bool = false
var customer_manager: CustomerManager

var default_texture: Texture2D
var dancing_near_texture: Texture2D
var dancing_far_texture: Texture2D
var dancing_near: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super(delta)
	#if not panel.visible:
		#panel.visible = true
		##green_patience_bar.visible = true
		##red_patience_bar.visible = true
		#green_patience_timer.start()


func initialize(texture: Texture2D, difficulty_level: int, patience_level: int, patience_time: float, value: int, new_customer_index: int) -> void:
	default_texture = texture
	super(texture, difficulty_level, patience_level, patience_time, value, new_customer_index)


func pause_timers() -> void:
	get_parent().green_patience_timer.stop()
	get_parent().red_patience_timer.stop()


func clear_pair() -> void:
	customer_manager.customer_array.erase(self)
	customer_manager.customer_array.erase(lover)
	customer_manager.customer_pairs.erase(get_parent())
	customer_manager.on_customer_left(0)
	customer_manager.spawnpoint_filled[get_parent().spawnpoint_index] = false  # free up a spawn area
	#SignalManager.customer_left.emit(0)
	get_parent().queue_free()


func die() -> void:
	if is_completed and lover.is_completed:
		clear_pair()
	else:
		get_parent().speed_up_patience_timers()


func talk(dialogue_file: String, section: String, time: float) -> void:
	var balloon = CUSTOMER_BALLOON.instantiate()
	add_child(balloon)
	balloon.advance_time = time
	balloon.offset = global_position + Vector2($CustomerButton.size.x / 2.0, -200.0)
	
	section = section + get_parent().get_bark()
	
	balloon.start(load(dialogue_file), section)


func set_sprite(texture: Texture2D) -> void:
	$Sprite2D.texture = texture


func invert_sprite_scale() -> void:
	$Sprite2D.scale.x *= -1.0


func _on_green_patience_timer_timeout() -> void:
	pass
